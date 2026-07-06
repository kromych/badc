
struct_param_stack_spill.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<f16>:
               	popq	%r10
               	subq	$0x90, %rsp
               	movq	0x90(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0x98(%rsp), %rax
               	movq	%rax, 0x70(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	0xb0(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0xb8(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x70(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x80(%rbp), %rcx
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	addq	%rax, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x90, %rsp
               	pushq	%r11
               	retq

<f12>:
               	popq	%r10
               	subq	$0x90, %rsp
               	movq	0x90(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0x98(%rsp), %rax
               	movq	%rax, 0x70(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	0xb0(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movzbq	0xb8(%rbp), %r10
               	movb	%r10b, -0x8(%rbp)
               	movzbq	0xb9(%rbp), %r10
               	movb	%r10b, -0x7(%rbp)
               	movzbq	0xba(%rbp), %r10
               	movb	%r10b, -0x6(%rbp)
               	movzbq	0xbb(%rbp), %r10
               	movb	%r10b, -0x5(%rbp)
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x70(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x80(%rbp), %rcx
               	addq	%rax, %rcx
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	imulq	$0x64, %rax, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rcx
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	imulq	$0xa, %rax, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rcx
               	leaq	-0x10(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x90, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movl	$0x7, %eax
               	movl	$0x8, %ebx
               	leaq	-0x10(%rbp), %r12
               	subq	$0x20, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%r12, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0xbe0, %rax            # imm = 0xBE0
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movl	$0x7, %eax
               	movl	$0x8, %ebx
               	leaq	-0x20(%rbp), %r12
               	subq	$0x20, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%r12, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movzbq	0x8(%r10), %r11
               	movb	%r11b, 0x18(%rsp)
               	movzbq	0x9(%r10), %r11
               	movb	%r11b, 0x19(%rsp)
               	movzbq	0xa(%r10), %r11
               	movb	%r11b, 0x1a(%rsp)
               	movzbq	0xb(%r10), %r11
               	movb	%r11b, 0x1b(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x10e, %rax            # imm = 0x10E
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
