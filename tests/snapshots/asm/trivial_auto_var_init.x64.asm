
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
               	subq	$0x10, %rsp
               	leaq	-0x2000(%rbp), %rdx
               	leaq	0x2000(%rdx), %rcx
               	movq	%rdx, %rax
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	addq	$0x8, %rax
               	cmpq	%rcx, %rax
               	jb	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rsi
               	movl	$0xaa, %edi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x2000, %ecx           # imm = 0x2000
               	jb	<addr>
               	xorq	%rax, %rax
               	addq	$0x2010, %rsp           # imm = 0x2010
               	popq	%rbp
               	retq

<mismatches>:
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	(%rdi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	jmp	<addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpq	%rsi, %rcx
               	jb	<addr>
               	movslq	%eax, %rax
               	retq

<scalar_int>:
               	xorq	%rax, %rax
               	retq

<scalar_short>:
               	xorq	%rax, %rax
               	retq

<scalar_char>:
               	xorq	%rax, %rax
               	retq

<scalar_long>:
               	xorq	%rax, %rax
               	retq

<scalar_ptr>:
               	xorq	%rax, %rax
               	retq

<scalar_double>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movsd	-0x10(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<scalar_float>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, %xmm14
               	movss	%xmm14, -0x10(%rbp,%riz)
               	movss	-0x10(%rbp,%riz), %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movl	(%rax), %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<scalar_long_double>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x10, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<scalar_int128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x10, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<array_sum>:
               	xorq	%rax, %rax
               	retq

<array_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movq	%rax, 0x10(%rdi)
               	movq	%rax, 0x18(%rdi)
               	movl	$0x20, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<struct_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x10(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movq	%rax, 0x8(%rdi)
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
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<union_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movl	$0x8, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<big_array>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x10, %rsp
               	leaq	-0x1000(%rbp), %rax
               	leaq	0x1000(%rax), %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	addq	$0x8, %rax
               	cmpq	%rcx, %rax
               	jb	<addr>
               	leaq	-0x1000(%rbp), %rdi
               	movl	$0x1000, %esi           # imm = 0x1000
               	callq	<addr>
               	movslq	%eax, %rax
               	addq	$0x1010, %rsp           # imm = 0x1010
               	popq	%rbp
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
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	addq	$0x8, %rax
               	cmpq	%rcx, %rax
               	jb	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	addq	$0x10, %rsp
               	popq	%rbp
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
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	addq	$0x8, %rax
               	cmpq	%rcx, %rax
               	jb	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<loop_block>:
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	movq	%rdx, %rax
               	jmp	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	retq

<addressed_int>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<opted_out>:
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%r12, %r12
               	callq	<addr>
               	callq	<addr>
               	leaq	(%rax), %rbx
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	movl	$0x25, %edi
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	addq	%rax, %rbx
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	%eax, %rax
               	jmp	<addr>
