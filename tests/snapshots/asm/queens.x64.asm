
queens.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<conflicts>:
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	%rsi, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	incq	%rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	%r8d, %r8
               	movslq	(%rdi,%rax,4), %rax
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	movslq	%eax, %r9
               	movslq	%r9d, %rax
               	cmpq	$0x0, %rax
               	jge	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	retq
               	movslq	%r9d, %rax
               	imulq	$-0x1, %rax, %r9
               	movslq	%ecx, %rax
               	movslq	(%rdi,%rax,4), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	%r8d, %rax
               	movslq	%r9d, %r8
               	cmpq	%r8, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	jmp	<addr>
               	jmp	<addr>

<solve>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movslq	%r12d, %r12
               	cmpq	$0x8, %r12
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %r15
               	movslq	%r14d, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%r14d, %rax
               	incq	%rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	movslq	%r14d, %rdx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%r14d, %rax
               	movl	%eax, (%rbx,%r12,4)
               	movslq	%r15d, %r15
               	movq	%r12, %rax
               	incq	%rax
               	movslq	%eax, %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r15, %rax
               	movslq	%eax, %r15
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5c, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
