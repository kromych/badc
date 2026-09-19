
trivial_auto_var_init.x64:	file format elf64-x86-64

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

<dirty>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	leaq	-0x2000(%rbp), %rcx
               	leaq	0x2000(%rcx), %rdx
               	movq	%rcx, %rax
               	cmpq	%rdx, %rax
               	jae	<addr>
               	movq	$0x0, (%rax)
               	addq	$0x8, %rax
               	cmpq	%rdx, %rax
               	jb	<addr>
               	xorl	%eax, %eax
               	leaq	(%rcx,%rax), %rdx
               	movb	$-0x56, (%rdx)
               	incq	%rax
               	cmpl	$0x2000, %eax           # imm = 0x2000
               	jb	<addr>
               	leave
               	retq

<mismatches>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpq	%rsi, %rcx
               	jae	<addr>
               	leaq	(%rdi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	testl	%edx, %edx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpq	%rsi, %rcx
               	jb	<addr>
               	movslq	%eax, %rax
               	retq

<scalar_int>:
               	xorl	%eax, %eax
               	retq

<scalar_short>:
               	xorl	%eax, %eax
               	retq

<scalar_char>:
               	xorl	%eax, %eax
               	retq

<scalar_long>:
               	xorl	%eax, %eax
               	retq

<scalar_ptr>:
               	xorl	%eax, %eax
               	retq

<scalar_double>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movq	%rax, -0x8(%rbp)
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	leave
               	retq

<scalar_float>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	leave
               	retq

<scalar_long_double>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	leave
               	retq

<scalar_int128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	leave
               	retq

<array_sum>:
               	xorl	%eax, %eax
               	retq

<array_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	leave
               	retq

<struct_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	leaq	-0x10(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x1, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	-0x10(%rbp), %rax
               	leaq	0x4(%rax), %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	addq	%rax, %rbx
               	leaq	-0x10(%rbp), %rax
               	leaq	0x8(%rax), %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq

<union_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movl	$0x8, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	leave
               	retq

<big_array>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	leaq	-0x1000(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movq	%rdi, %r10
               	leaq	0x1000(%r10), %r11
               	movups	%xmm14, (%r10)
               	addq	$0x10, %r10
               	cmpq	%r11, %r10
               	jb	<addr>
               	movl	$0x1000, %esi           # imm = 0x1000
               	callq	<addr>
               	movslq	%eax, %rax
               	leave
               	retq

<vla_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, %rsi
               	shlq	$0x3, %rsi
               	movq	%rsi, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdi
               	subq	%r11, %rdi
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rdi, %rsp
               	leaq	0x7(%rsi), %rax
               	andq	$-0x8, %rax
               	leaq	(%rdi,%rax), %rcx
               	movq	%rdi, %rax
               	cmpq	%rcx, %rax
               	jae	<addr>
               	movq	$0x0, (%rax)
               	addq	$0x8, %rax
               	cmpq	%rcx, %rax
               	jb	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<vla_odd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x5, %esi
               	movq	%rsi, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdi
               	subq	%r11, %rdi
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rdi, %rsp
               	leaq	0x8(%rdi), %rcx
               	movq	%rdi, %rax
               	cmpq	%rcx, %rax
               	jae	<addr>
               	movq	$0x0, (%rax)
               	addq	$0x8, %rax
               	cmpq	%rcx, %rax
               	jb	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<loop_block>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	retq

<addressed_int>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	leave
               	retq

<opted_out>:
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %r12
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %r12
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %r12
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %r12
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %r12
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %r12
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %r12
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %r12
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %r12
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %r12
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %r12
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %r12
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %r12
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %r12
               	callq	<addr>
               	movl	$0x25, %edi
               	callq	<addr>
               	addq	%rax, %r12
               	callq	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	addq	%rax, %r12
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	(%r12,%rax), %rbx
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	cmpl	$0x64, %eax
               	jle	<addr>
               	movl	$0x64, %eax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
