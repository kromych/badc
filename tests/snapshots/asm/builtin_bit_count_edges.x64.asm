
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
               	subq	$0x18, %rsp
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %r8 # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %r9 # <addr>
               	movl	%edi, %ecx
               	movl	$0x3f, %r11d
               	bsrl	%r8d, %esi
               	cmovel	%r11d, %esi
               	xorl	$0x1f, %esi
               	xorl	%eax, %eax
               	movl	$0x1f, %edx
               	subq	%rax, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x20, %r11d
               	bsfl	%r8d, %esi
               	cmovel	%r11d, %esi
               	xorl	%eax, %eax
               	shrxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	popcntl	%r8d, %r10d
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shrxq	%rax, %rcx, %rsi
               	andq	$0x1, %rsi
               	addq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%edx, %r10d
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	%r8, (%rsp)
               	movl	%r9d, %r8d
               	shll	%r8d
               	xorl	%r9d, %r8d
               	orl	$0x1, %r8d
               	bsrl	%r8d, %r10d
               	xorl	$0x1f, %r10d
               	movq	%rcx, %rsi
               	shrq	$0x1f, %rsi
               	xorl	%eax, %eax
               	movq	(%rsp), %r8
               	movl	$0x1e, %edx
               	subq	%rax, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0x1, %rdx
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x1f, %eax
               	jl	<addr>
               	cmpl	%eax, %r10d
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x20, %r11d
               	bsfl	%r9d, %eax
               	cmovel	%r11d, %eax
               	leaq	0x1(%rax), %rsi
               	shrq	$0x5, %rax
               	decq	%rax
               	andq	%rax, %rsi
               	xorl	%eax, %eax
               	shrxq	%rax, %rcx, %rdx
               	nopw	(%rax,%rax)
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%edx, %edx
               	leaq	0x1(%rax), %r9
               	cmpl	$0x20, %eax
               	cmovneq	%r9, %rdx
               	cmpl	%edx, %esi
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	popcntl	%r8d, %r9d
               	andq	$0x1, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shrxq	%rax, %rcx, %rsi
               	andq	$0x1, %rsi
               	addq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	andq	$0x1, %rdx
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movl	$0x3f, %r11d
               	bsrl	%eax, %esi
               	cmovel	%r11d, %esi
               	xorl	$0x1f, %esi
               	xorl	%eax, %eax
               	movl	$0x1f, %edx
               	subq	%rax, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movl	$0x20, %r11d
               	bsfl	%eax, %esi
               	cmovel	%r11d, %esi
               	xorl	%eax, %eax
               	shrxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	popcntl	%eax, %edi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shrxq	%rax, %rcx, %rsi
               	andq	$0x1, %rsi
               	addq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%edx, %edi
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3f, %r11d
               	bsrl	%r8d, %eax
               	cmovel	%r11d, %eax
               	xorl	$0x1f, %eax
               	leaq	-0x21(%rax), %rsi
               	xorl	%eax, %eax
               	movl	$0x1f, %edx
               	subq	%rax, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	nop
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	subq	$0x21, %rax
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	%r8, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	popcntl	%eax, %r9d
               	movq	%rcx, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shrxq	%rax, %rdi, %rsi
               	andq	$0x1, %rsi
               	addq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	%r8, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movl	$0x3f, %r11d
               	bsrl	%eax, %edi
               	cmovel	%r11d, %edi
               	xorl	$0x1f, %edi
               	movq	%rcx, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	xorl	%eax, %eax
               	movl	$0x1f, %edx
               	subq	%rax, %rdx
               	shrxq	%rdx, %rsi, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%eax, %edi
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3f, %r11d
               	bsrl	%r8d, %eax
               	cmovel	%r11d, %eax
               	xorl	$0x1f, %eax
               	imulq	$0xf4240, %rax, %rax    # imm = 0xF4240
               	movl	$0x20, %r11d
               	bsfl	%r8d, %edx
               	cmovel	%r11d, %edx
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	addq	%rdx, %rax
               	popcntl	%r8d, %edx
               	leaq	(%rax,%rdx), %rdi
               	xorl	%eax, %eax
               	movl	$0x1f, %edx
               	subq	%rax, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	nopl	(%rax,%rax)
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	imulq	$0xf4240, %rax, %rsi    # imm = 0xF4240
               	xorl	%eax, %eax
               	shrxq	%rax, %rcx, %rdx
               	nopl	(%rax,%rax)
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
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq

<check64>:
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %r8 # <addr>
               	movl	$0x7f, %r11d
               	bsrq	%rsi, %rdx
               	cmovel	%r11d, %edx
               	xorl	$0x3f, %edx
               	xorl	%eax, %eax
               	movl	$0x3f, %ecx
               	subq	%rax, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	nopl	(%rax)
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	$0x40, %r11d
               	bsfq	%rsi, %rdx
               	cmovel	%r11d, %edx
               	xorl	%eax, %eax
               	shrxq	%rax, %rdi, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	popcntq	%rsi, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shrxq	%rax, %rdi, %rdx
               	andq	$0x1, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	nopl	(%rax)
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
               	movq	%rdi, %rdx
               	shrq	$0x3f, %rdx
               	xorl	%eax, %eax
               	movl	$0x3e, %ecx
               	subq	%rax, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	andq	$0x1, %rcx
               	nop
               	cmpl	%edx, %ecx
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
               	leaq	0x1(%rax), %rdx
               	shrq	$0x6, %rax
               	decq	%rax
               	andq	%rax, %rdx
               	xorl	%eax, %eax
               	shrxq	%rax, %rdi, %rcx
               	nopw	(%rax,%rax)
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	0x1(%rax), %r8
               	cmpl	$0x40, %eax
               	cmovneq	%r8, %rcx
               	cmpl	%ecx, %edx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	popcntq	%rsi, %r8
               	andq	$0x1, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shrxq	%rax, %rdi, %rdx
               	andq	$0x1, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	andq	$0x1, %rcx
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movl	$0x40, %r11d
               	bsfq	%rsi, %rax
               	cmovel	%r11d, %eax
               	leaq	-0x41(%rax), %rdx
               	xorl	%eax, %eax
               	shrxq	%rax, %rdi, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	subq	$0x41, %rax
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	movl	%esi, %eax
               	popcntq	%rax, %r9
               	movl	%edi, %r8d
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shrxq	%rax, %r8, %rdx
               	andq	$0x1, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%ecx, %r9d
               	je	<addr>
               	movl	$0x1b, %eax
               	retq
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	orq	%rsi, %rax
               	bsrq	%rax, %r8
               	xorl	$0x3f, %r8d
               	movabsq	$0x100000000, %rdx      # imm = 0x100000000
               	orq	%rdi, %rdx
               	xorl	%eax, %eax
               	movl	$0x3f, %ecx
               	subq	%rax, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %r8d
               	je	<addr>
               	movl	$0x1c, %eax
               	retq
               	movl	$0x7f, %r11d
               	bsrq	%rsi, %rax
               	cmovel	%r11d, %eax
               	xorl	$0x3f, %eax
               	imulq	$0xf4240, %rax, %rax    # imm = 0xF4240
               	movl	$0x40, %r11d
               	bsfq	%rsi, %rcx
               	cmovel	%r11d, %ecx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	popcntq	%rsi, %rcx
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
               	movq	<rip>, %rsi # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	<rip>, %r8 # <addr>
               	movl	$0x7f, %r11d
               	bsrq	%rsi, %rdx
               	cmovel	%r11d, %edx
               	xorl	$0x3f, %edx
               	xorl	%eax, %eax
               	movl	$0x3f, %ecx
               	subq	%rax, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	nopl	(%rax)
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	movl	$0x40, %r11d
               	bsfq	%rsi, %rdx
               	cmovel	%r11d, %edx
               	xorl	%eax, %eax
               	shrxq	%rax, %rdi, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	popcntq	%rsi, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shrxq	%rax, %rdi, %rdx
               	andq	$0x1, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	nopl	(%rax)
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
               	movq	%rdi, %rdx
               	shrq	$0x3f, %rdx
               	xorl	%eax, %eax
               	movl	$0x3e, %ecx
               	subq	%rax, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	andq	$0x1, %rcx
               	nop
               	cmpl	%edx, %ecx
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
               	leaq	0x1(%rax), %rdx
               	shrq	$0x6, %rax
               	decq	%rax
               	andq	%rax, %rdx
               	xorl	%eax, %eax
               	shrxq	%rax, %rdi, %rcx
               	nopw	(%rax,%rax)
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	0x1(%rax), %r8
               	cmpl	$0x40, %eax
               	cmovneq	%r8, %rcx
               	cmpl	%ecx, %edx
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	popcntq	%rsi, %rsi
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
               	nopl	(%rax)
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
               	nopl	(%rax,%rax)
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x1(%r12), %r13
               	movq	%r13, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r13, %rdi
               	callq	<addr>
               	nopl	(%rax)
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
               	nop
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r13, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r13, %rdi
               	callq	<addr>
               	nopl	(%rax,%rax)
               	testl	%eax, %eax
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	nopl	(%rax)
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	nopl	(%rax)
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
               	retq
               	xorl	%esi, %esi
               	movl	$0x1, %eax
               	shlxq	%rsi, %rax, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rdi # <addr>
               	movl	%edi, %edx
               	orq	$0x1, %rdx
               	bsfl	%edx, %r8d
               	xorl	%eax, %eax
               	shrxq	%rax, %rdx, %rcx
               	nopw	(%rax,%rax)
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movl	%edi, %edx
               	orq	$0x1, %rdx
               	bsrl	%edx, %r8d
               	xorl	$0x1f, %r8d
               	xorl	%eax, %eax
               	movl	$0x1f, %ecx
               	subq	%rax, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%rdi, %rdx
               	orq	$0x1, %rdx
               	bsfq	%rdx, %r8
               	xorl	%eax, %eax
               	shrxq	%rax, %rdx, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%rdi, %rdx
               	orq	$0x1, %rdx
               	bsrq	%rdx, %rdi
               	xorl	$0x3f, %edi
               	xorl	%eax, %eax
               	movl	$0x3f, %ecx
               	subq	%rax, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax,%rax)
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
               	nop
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpq	$0x820, %rcx            # imm = 0x820
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
               	movl	$0x1c, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
               	movl	$0x1b, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
               	movl	$0x1a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
               	movl	$0x19, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
