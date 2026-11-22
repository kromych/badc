
indirect_call_imm_target_direct.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<fact>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	cmpl	$0x2, %edi
               	jge	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x1(%rdi), %rcx
               	cmpl	$0x2, %ecx
               	jge	<addr>
               	movl	$0x1, %eax
               	imulq	%rdi, %rax
               	jmp	<addr>
               	leaq	-0x1(%rcx), %rdx
               	cmpl	$0x2, %edx
               	jge	<addr>
               	movl	$0x1, %eax
               	imulq	%rcx, %rax
               	jmp	<addr>
               	leaq	-0x1(%rdx), %rsi
               	cmpl	$0x2, %esi
               	jge	<addr>
               	movl	$0x1, %eax
               	imulq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x1(%rsi), %rax
               	movq	%rdi, 0x18(%rsp)
               	movq	%rcx, 0x10(%rsp)
               	movq	%rdx, 0x8(%rsp)
               	movq	%rsi, (%rsp)
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	0x18(%rsp), %rdi
               	movq	0x10(%rsp), %rcx
               	movq	0x8(%rsp), %rdx
               	movq	(%rsp), %rsi
               	imulq	%rsi, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
