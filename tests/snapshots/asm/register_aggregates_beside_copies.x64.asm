
register_aggregates_beside_copies.x64:	file format elf64-x86-64

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

<make_w>:
               	leaq	(%rdi,%rdi,2), %rax
               	retq

<make_s>:
               	movsbq	%dil, %rax
               	imulq	$0x7, %rdi, %rcx
               	andq	$0xff, %rax
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	retq

<make_p>:
               	movq	%rdi, %rax
               	movq	%rax, %rdx
               	negq	%rdx
               	retq

<make_b>:
               	movsbq	%dil, %rdi
               	andq	$0xff, %rdi
               	orq	$0x100, %rdi            # imm = 0x100
               	orq	$0x20000, %rdi          # imm = 0x20000
               	orq	$0x3000000, %rdi        # imm = 0x3000000
               	movq	%rdi, %rax
               	retq

<param_beside>:
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	andq	$0xff, %rdi
               	movsbq	%dil, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsi), %rcx
               	addq	%rcx, %rax
               	retq

<results_beside>:
               	pushq	%rax
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rbx)
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, %r12
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, %r13
               	shrq	$0x20, %r13
               	movq	%rax, %r14
               	andq	$0xff, %r14
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, %r15
               	movq	%rdx, %rbp
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rax
               	andq	$0xff, %rcx
               	movsbq	%r14b, %rdx
               	addq	%r12, %rdx
               	movslq	%r13d, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdx,%r15), %rsi
               	subq	%rbp, %rsi
               	movsbq	%al, %rax
               	addq	%rsi, %rax
               	movsbq	%cl, %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rbx), %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%r11
               	retq

<main>:
               	subq	$0x38, %rsp
               	movq	<rip>, %rax # <addr>
               	movq	%rax, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	shlq	%rax
               	movq	%rax, 0x18(%rsp)
               	leaq	0x20(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x8(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	leaq	0x10(%rsp), %rdx
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x30, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x20(%rsp), %rdi
               	leaq	0x10(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0x53, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
