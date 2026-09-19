
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
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	cmpl	%edi, %ecx
               	jge	<addr>
               	imulq	$0x55555556, %rcx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rsi
               	movq	%rcx, %rdx
               	subq	%rsi, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	addq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0x1, %edx
               	jne	<addr>
               	decq	%rax
               	jmp	<addr>
               	addq	$0x2, %rax
               	incq	%rcx
               	cmpl	%edi, %ecx
               	jl	<addr>
               	movslq	%eax, %rax
               	retq

<main>:
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	imulq	$0x55555556, %rcx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rsi
               	movq	%rcx, %rdx
               	subq	%rsi, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	addq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0x1, %edx
               	jne	<addr>
               	decq	%rax
               	jmp	<addr>
               	addq	$0x2, %rax
               	incq	%rcx
               	cmpl	$0xa, %ecx
               	jl	<addr>
               	movslq	%eax, %rax
               	retq
