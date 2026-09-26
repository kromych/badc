
inline_asm_x64_bound_operands.x64:	file format elf64-x86-64

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

<add2>:
               	movq	%rdi, %rax
               	addq	%rsi, %rax
               	retq

<sum3>:
               	leaq	(%rdi,%rsi), %r11
               	leaq	(%r11,%rdx), %rax
               	retq

<keep_old>:
               	movq	%rdi, %rax
               	addq	%rsi, %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	%rdi, %rax
               	retq

<scratch_clobbered>:
               	movq	%rdx, %rcx
               	movq	%rdi, %rax
               	addq	%rsi, %rax
               	addq	%rcx, %rax
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	retq

<sink>:
               	leaq	0x1(%rdi), %rax
               	retq

<across_call>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%r9, 0x38(%rsp)
               	movq	%r8, %r15
               	movq	%rcx, %r14
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	(%rbx,%r12), %r11
               	leaq	(%r11,%r13), %rcx
               	movq	0x38(%rsp), %r10
               	leaq	(%r14,%r15), %r11
               	leaq	(%r11,%r10), %rdx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<vec_add>:
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	movups	0x10(%rax), %xmm1
               	vpaddd	%xmm1, %xmm0, %xmm0
               	leaq	<rip>, %rax
               	movups	%xmm0, (%rax)
               	retq

<vec_across_call>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	xorl	%edi, %edi
               	movups	(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsp)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, (%rsp)
               	callq	<addr>
               	movups	(%rsp), %xmm14
               	movups	0x10(%rsp), %xmm0
               	paddd	%xmm14, %xmm0
               	leaq	<rip>, %rcx
               	movups	%xmm0, 0x10(%rcx)
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %r13
               	movq	0x18(%rax), %r14
               	movq	0x20(%rax), %r12
               	movq	0x28(%rax), %r15
               	movq	0x30(%rax), %rbx
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	0x1(%rbx), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x26, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r13, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	callq	<addr>
               	cmpq	$0x6, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movl	$0x2, %r9d
               	movl	$0x3, %r8d
               	addq	%r9, %rax
               	addq	%r8, %rax
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x64, %eax
               	leaq	<rip>, %r10
               	movl	$0x5, %r11d
               	addq	0x8(%r10), %rax
               	addq	%r11, %rax
               	cmpq	$0x6e, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	0x1(%rbx), %r9
               	movq	%r13, %rdi
               	movq	%rbx, %r8
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	callq	<addr>
               	cmpq	$0x269, %rax            # imm = 0x269
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0xc(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x6e, %eax
               	jne	<addr>
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0xc(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x6e, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
