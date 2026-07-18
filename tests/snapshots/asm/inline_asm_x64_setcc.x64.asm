
inline_asm_x64_setcc.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<cmp_eq>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rbx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	0x8(%rsp), %rbx
               	movq	(%rsp), %rcx
               	cmpq	%rcx, %rbx
               	sete	%al
               	movq	0x10(%rsp), %r11
               	movb	%al, (%r11)
               	addq	$0x18, %rsp
               	popq	%rbx
               	popq	%rcx
               	popq	%rax
               	movzbq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<cmp_lt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rbx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	0x8(%rsp), %rbx
               	movq	(%rsp), %rcx
               	cmpq	%rcx, %rbx
               	setl	%al
               	movq	0x10(%rsp), %r11
               	movb	%al, (%r11)
               	addq	$0x18, %rsp
               	popq	%rbx
               	popq	%rcx
               	popq	%rax
               	movzbq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<cmp_gt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rbx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	0x8(%rsp), %rbx
               	movq	(%rsp), %rcx
               	cmpq	%rcx, %rbx
               	setg	%al
               	movq	0x10(%rsp), %r11
               	movb	%al, (%r11)
               	addq	$0x18, %rsp
               	popq	%rbx
               	popq	%rcx
               	popq	%rax
               	movzbq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movl	$0x5, %edi
               	movq	%rdi, %rsi
               	callq	<addr>
               	imulq	$0x14, %rax, %rax
               	leaq	(%rax), %rbx
               	movl	$0x3, %r12d
               	movl	$0x7, %esi
               	movq	%r12, %rdi
               	callq	<addr>
               	imulq	$0xf, %rax, %rax
               	leaq	(%rbx,%rax), %r13
               	movl	$0x9, %ebx
               	movl	$0x4, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	<addr>
               	imulq	$0x7, %rax, %rax
               	addq	%rax, %r13
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x64, %rax, %rax
               	leaq	(%r13,%rax), %r12
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	imulq	$0x64, %rax, %rax
               	addq	%r12, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
