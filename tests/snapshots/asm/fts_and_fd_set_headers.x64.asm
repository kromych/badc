
fts_and_fd_set_headers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	leaq	-0x80(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	popq	%r11
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movq	%rcx, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	leaq	-0xa0(%rbp), %rdi
               	movl	$0x14, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movzwq	0x62(%r12), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	0x30(%r12), %rax
               	testq	%rax, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	movq	0x30(%r12), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x2e, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movzwq	0x40(%r12), %r14
               	movq	0x30(%r12), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpq	%rax, %r14
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
