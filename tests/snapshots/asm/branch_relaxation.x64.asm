
branch_relaxation.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<classify>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	jmp	<addr>
               	incq	%rax
               	cmpl	%edi, %eax
               	jge	<addr>
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rsi
               	movq	%rax, %rdx
               	subq	%rsi, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	addq	%rax, %rcx
               	jmp	<addr>
               	leaq	-0x1(%rcx), %rsi
               	addq	$0x2, %rcx
               	cmpl	$0x1, %edx
               	cmoveq	%rsi, %rcx
               	jmp	<addr>
               	movq	%rcx, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0xa, %eax
               	jge	<addr>
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rsi
               	movq	%rax, %rdx
               	subq	%rsi, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	addq	%rax, %rcx
               	jmp	<addr>
               	leaq	-0x1(%rcx), %rsi
               	addq	$0x2, %rcx
               	cmpl	$0x1, %edx
               	cmoveq	%rsi, %rcx
               	jmp	<addr>
               	movq	%rcx, %rax
               	retq
