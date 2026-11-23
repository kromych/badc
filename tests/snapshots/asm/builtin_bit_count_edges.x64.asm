
builtin_bit_count_edges.x64:	file format elf64-x86-64

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

<check32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %r9 # <addr>
               	movl	%edi, %ecx
               	movl	$0x3f, %r11d
               	bsrl	%esi, %r8d
               	cmovel	%r11d, %r8d
               	xorl	$0x1f, %r8d
               	xorl	%eax, %eax
               	movl	$0x1f, %edx
               	subq	%rax, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%eax, %r8d
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x20, %r11d
               	bsfl	%esi, %r8d
               	cmovel	%r11d, %r8d
               	xorl	%eax, %eax
               	shrxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%eax, %r8d
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	popcntl	%esi, %r10d
               	movq	%r10, 0x8(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shrxq	%rax, %rcx, %r8
               	andq	$0x1, %r8
               	addq	%r8, %rdx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	0x8(%rsp), %rax
               	cmpl	%edx, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	%r9d, %r11d
               	shll	%r11d
               	xorl	%r9d, %r11d
               	orl	$0x1, %r11d
               	bsrl	%r11d, %r10d
               	xorl	$0x1f, %r10d
               	movq	%r10, 0x8(%rsp)
               	movq	%rcx, %rdx
               	shrq	$0x1f, %rdx
               	xorl	%eax, %eax
               	movl	$0x1e, %r8d
               	subq	%rax, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0x1, %r8
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x1f, %eax
               	jl	<addr>
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpl	%r10d, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x20, %r11d
               	bsfl	%r9d, %eax
               	cmovel	%r11d, %eax
               	leaq	0x1(%rax), %rdx
               	shrq	$0x5, %rax
               	decq	%rax
               	movq	%rdx, %r8
               	andq	%rax, %r8
               	xorl	%eax, %eax
               	shrxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%edx, %edx
               	leaq	0x1(%rax), %r9
               	cmpl	$0x20, %eax
               	cmovneq	%r9, %rdx
               	cmpl	%edx, %r8d
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	popcntl	%esi, %eax
               	movq	%rax, %r9
               	andq	$0x1, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shrxq	%rax, %rcx, %r8
               	andq	$0x1, %r8
               	addq	%r8, %rdx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	andq	$0x1, %rdx
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movl	$0x3f, %r11d
               	bsrl	%eax, %r8d
               	cmovel	%r11d, %r8d
               	xorl	$0x1f, %r8d
               	xorl	%eax, %eax
               	movl	$0x1f, %edx
               	subq	%rax, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%eax, %r8d
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movl	$0x20, %r11d
               	bsfl	%eax, %r8d
               	cmovel	%r11d, %r8d
               	xorl	%eax, %eax
               	shrxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%eax, %r8d
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	popcntl	%eax, %r8d
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shrxq	%rax, %rcx, %rdi
               	andq	$0x1, %rdi
               	addq	%rdi, %rdx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%edx, %r8d
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x3f, %r11d
               	bsrl	%esi, %eax
               	cmovel	%r11d, %eax
               	xorl	$0x1f, %eax
               	leaq	-0x21(%rax), %rdi
               	xorl	%eax, %eax
               	movl	$0x1f, %edx
               	subq	%rax, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	subq	$0x21, %rax
               	cmpl	%eax, %edi
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	%rsi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	popcntl	%eax, %r9d
               	movq	%rcx, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shrxq	%rax, %rdi, %r8
               	andq	$0x1, %r8
               	addq	%r8, %rdx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movq	%rsi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movl	$0x3f, %r11d
               	bsrl	%eax, %r8d
               	cmovel	%r11d, %r8d
               	xorl	$0x1f, %r8d
               	movq	%rcx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	xorl	%eax, %eax
               	movl	$0x1f, %edi
               	subq	%rax, %rdi
               	shrxq	%rdi, %rdx, %rdi
               	testb	$0x1, %dil
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%eax, %r8d
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	movl	$0x3f, %r11d
               	bsrl	%esi, %eax
               	cmovel	%r11d, %eax
               	xorl	$0x1f, %eax
               	imulq	$0xf4240, %rax, %rax    # imm = 0xF4240
               	movl	$0x20, %r11d
               	bsfl	%esi, %edx
               	cmovel	%r11d, %edx
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	addq	%rdx, %rax
               	popcntl	%esi, %edx
               	leaq	(%rax,%rdx), %rdi
               	xorl	%eax, %eax
               	movl	$0x1f, %edx
               	subq	%rax, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	imulq	$0xf4240, %rax, %rsi    # imm = 0xF4240
               	xorl	%eax, %eax
               	shrxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	leaq	(%rsi,%rax), %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shrxq	%rax, %rcx, %rsi
               	andq	$0x1, %rsi
               	addq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movslq	%edx, %rax
               	addq	%r8, %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

<check64>:
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %r8 # <addr>
               	movl	$0x7f, %r11d
               	bsrq	%rdx, %rsi
               	cmovel	%r11d, %esi
               	xorl	$0x3f, %esi
               	xorl	%eax, %eax
               	movl	$0x3f, %ecx
               	subq	%rax, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	$0x40, %r11d
               	bsfq	%rdx, %rsi
               	cmovel	%r11d, %esi
               	xorl	%eax, %eax
               	shrxq	%rax, %rdi, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	popcntq	%rdx, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shrxq	%rax, %rdi, %rsi
               	andq	$0x1, %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%ecx, %r9d
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movq	%r8, %r11
               	shlq	%r11
               	xorq	%r8, %r11
               	orq	$0x1, %r11
               	bsrq	%r11, %r9
               	xorl	$0x3f, %r9d
               	movq	%rdi, %rcx
               	shrq	$0x3f, %rcx
               	xorl	%eax, %eax
               	movl	$0x3e, %esi
               	subq	%rax, %rsi
               	shrxq	%rsi, %rdi, %rsi
               	andq	$0x1, %rsi
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3f, %eax
               	jl	<addr>
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movl	$0x40, %r11d
               	bsfq	%r8, %rax
               	cmovel	%r11d, %eax
               	leaq	0x1(%rax), %rcx
               	shrq	$0x6, %rax
               	decq	%rax
               	movq	%rcx, %rsi
               	andq	%rax, %rsi
               	xorl	%eax, %eax
               	shrxq	%rax, %rdi, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	0x1(%rax), %r8
               	cmpl	$0x40, %eax
               	cmovneq	%r8, %rcx
               	cmpl	%ecx, %esi
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	popcntq	%rdx, %rax
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shrxq	%rax, %rdi, %rsi
               	andq	$0x1, %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	andq	$0x1, %rcx
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movl	$0x40, %r11d
               	bsfq	%rdx, %rax
               	cmovel	%r11d, %eax
               	leaq	-0x41(%rax), %rsi
               	xorl	%eax, %eax
               	shrxq	%rax, %rdi, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	subq	$0x41, %rax
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	movl	%edx, %eax
               	popcntq	%rax, %r9
               	movl	%edi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shrxq	%rax, %rsi, %r8
               	andq	$0x1, %r8
               	addq	%r8, %rcx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%ecx, %r9d
               	je	<addr>
               	movl	$0x1b, %eax
               	retq
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	orq	%rdx, %rax
               	bsrq	%rax, %r8
               	xorl	$0x3f, %r8d
               	movabsq	$0x100000000, %rcx      # imm = 0x100000000
               	orq	%rdi, %rcx
               	xorl	%eax, %eax
               	movl	$0x3f, %esi
               	subq	%rax, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	testb	$0x1, %sil
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %r8d
               	je	<addr>
               	movl	$0x1c, %eax
               	retq
               	movl	$0x7f, %r11d
               	bsrq	%rdx, %rax
               	cmovel	%r11d, %eax
               	xorl	$0x3f, %eax
               	imulq	$0xf4240, %rax, %rax    # imm = 0xF4240
               	movl	$0x40, %r11d
               	bsfq	%rdx, %rcx
               	cmovel	%r11d, %ecx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	popcntq	%rdx, %rcx
               	leaq	(%rax,%rcx), %rsi
               	xorl	%eax, %eax
               	movl	$0x3f, %ecx
               	subq	%rax, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	imulq	$0xf4240, %rax, %rdx    # imm = 0xF4240
               	xorl	%eax, %eax
               	shrxq	%rax, %rdi, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	leaq	(%rdx,%rax), %r8
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shrxq	%rax, %rdi, %rdx
               	andq	$0x1, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	addq	%r8, %rax
               	cmpq	%rax, %rsi
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<check_long>:
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %r8 # <addr>
               	movl	$0x7f, %r11d
               	bsrq	%rdx, %rsi
               	cmovel	%r11d, %esi
               	xorl	$0x3f, %esi
               	xorl	%eax, %eax
               	movl	$0x3f, %ecx
               	subq	%rax, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	movl	$0x40, %r11d
               	bsfq	%rdx, %rsi
               	cmovel	%r11d, %esi
               	xorl	%eax, %eax
               	shrxq	%rax, %rdi, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	popcntq	%rdx, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shrxq	%rax, %rdi, %rsi
               	andq	$0x1, %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%ecx, %r9d
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	movq	%r8, %r11
               	shlq	%r11
               	xorq	%r8, %r11
               	orq	$0x1, %r11
               	bsrq	%r11, %r9
               	xorl	$0x3f, %r9d
               	movq	%rdi, %rcx
               	shrq	$0x3f, %rcx
               	xorl	%eax, %eax
               	movl	$0x3e, %esi
               	subq	%rax, %rsi
               	shrxq	%rsi, %rdi, %rsi
               	andq	$0x1, %rsi
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3f, %eax
               	jl	<addr>
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movl	$0x40, %r11d
               	bsfq	%r8, %rax
               	cmovel	%r11d, %eax
               	leaq	0x1(%rax), %rcx
               	shrq	$0x6, %rax
               	decq	%rax
               	movq	%rcx, %rsi
               	andq	%rax, %rsi
               	xorl	%eax, %eax
               	shrxq	%rax, %rdi, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	0x1(%rax), %r8
               	cmpl	$0x40, %eax
               	cmovneq	%r8, %rcx
               	cmpl	%ecx, %esi
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	popcntq	%rdx, %rax
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shrxq	%rax, %rdi, %rdx
               	andq	$0x1, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	andq	$0x1, %rcx
               	cmpl	%ecx, %esi
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	$-0x1, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	$-0x1, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	$-0x1, %rdi
               	callq	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	incq	%rbx
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x40, %ebx
               	jge	<addr>
               	movl	$0x1, %eax
               	shlxq	%rbx, %rax, %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x1(%r12), %r13
               	movq	%r13, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r13, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r13, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r12, %r13
               	negq	%r13
               	movq	%r13, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r13, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r13, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	incq	%rbx
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0xa, %ebx
               	jae	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	jmp	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x1, %eax
               	shlxq	%rsi, %rax, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rdi # <addr>
               	movl	%edi, %ecx
               	orq	$0x1, %rcx
               	bsfl	%ecx, %r8d
               	xorl	%eax, %eax
               	shrxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movl	%edi, %ecx
               	orq	$0x1, %rcx
               	bsrl	%ecx, %r8d
               	xorl	$0x1f, %r8d
               	xorl	%eax, %eax
               	movl	$0x1f, %edx
               	subq	%rax, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%rdi, %rcx
               	orq	$0x1, %rcx
               	bsfq	%rcx, %r8
               	xorl	%eax, %eax
               	shrxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%rdi, %rcx
               	orq	$0x1, %rcx
               	bsrq	%rcx, %rdi
               	xorl	$0x3f, %edi
               	xorl	%eax, %eax
               	movl	$0x3f, %edx
               	subq	%rax, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %edi
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x40, %esi
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	$-0x1, %rdx
               	shrxq	%rax, %rdx, %rdx
               	movq	%rdx, <rip> # <addr>
               	movq	<rip>, %rdx # <addr>
               	popcntq	%rdx, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpq	$0x820, %rcx            # imm = 0x820
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1c, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1b, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x19, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
