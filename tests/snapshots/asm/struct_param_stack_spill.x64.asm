
struct_param_stack_spill.x64:	file format elf64-x86-64

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

<f16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rbp), %rcx
               	addq	%rax, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	leave
               	retq

<f12>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movzbq	0x28(%rbp), %r10
               	movb	%r10b, -0x8(%rbp)
               	movzbq	0x29(%rbp), %r10
               	movb	%r10b, -0x7(%rbp)
               	movzbq	0x2a(%rbp), %r10
               	movb	%r10b, -0x6(%rbp)
               	movzbq	0x2b(%rbp), %r10
               	movb	%r10b, -0x5(%rbp)
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rbp), %rcx
               	leaq	(%rax,%rcx), %rdx
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	imulq	$0x64, %rcx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	movslq	0x4(%rax), %rcx
               	imulq	$0xa, %rcx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movl	$0x1, %eax
               	movq	%rax, -0x10(%rbp)
               	movl	$0x2, %esi
               	movl	%esi, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	-0x10(%rbp), %rdi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movl	$0x7, %ebx
               	movl	$0x8, %r12d
               	leaq	-0x20(%rbp), %r13
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	*%rax
               	addq	$0x20, %rsp
               	cmpq	$0xbe0, %rax            # imm = 0xBE0
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movl	%ecx, 0x8(%rax)
               	movslq	-0x8(%rbp), %rcx
               	movl	%ecx, (%rax)
               	movl	$0x3, %edx
               	movl	%edx, 0x4(%rax)
               	movl	$0x4, %ecx
               	movl	%ecx, 0x8(%rax)
               	movq	-0x10(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movl	$0x7, %ebx
               	movl	$0x8, %r12d
               	leaq	-0x20(%rbp), %r13
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, %r10
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
               	callq	*%rax
               	addq	$0x20, %rsp
               	cmpq	$0x10e, %rax            # imm = 0x10E
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
