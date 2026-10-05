
builtin_bit_count_edges.x64:	file format elf64-x86-64

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

<check32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	%rdi, (%rax)
               	movq	(%rax), %rsi
               	movq	%rdi, (%rax)
               	movq	(%rax), %r9
               	movl	%edi, %eax
               	movl	$0x3f, %r11d
               	bsrl	%esi, %r8d
               	cmovel	%r11d, %r8d
               	xorl	$0x1f, %r8d
               	xorl	%ecx, %ecx
               	movl	$0x1f, %edx
               	subq	%rcx, %rdx
               	shrxq	%rdx, %rax, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x20, %r11d
               	bsfl	%esi, %r8d
               	cmovel	%r11d, %r8d
               	xorl	%ecx, %ecx
               	shrxq	%rcx, %rax, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	popcntl	%esi, %ebx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shrxq	%rcx, %rax, %r8
               	andq	$0x1, %r8
               	addq	%r8, %rdx
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	%edx, %ebx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	%r9d, %r11d
               	shll	%r11d
               	xorl	%r9d, %r11d
               	orl	$0x1, %r11d
               	bsrl	%r11d, %ebx
               	xorl	$0x1f, %ebx
               	movq	%rax, %rdx
               	shrq	$0x1f, %rdx
               	xorl	%ecx, %ecx
               	movl	$0x1e, %r8d
               	subq	%rcx, %r8
               	shrxq	%r8, %rax, %r8
               	andq	$0x1, %r8
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x1f, %ecx
               	jl	<addr>
               	cmpl	%ecx, %ebx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x20, %r11d
               	bsfl	%r9d, %edx
               	cmovel	%r11d, %edx
               	xorl	%ecx, %ecx
               	cmpl	$0x20, %edx
               	leaq	0x1(%rdx), %r8
               	cmovel	%ecx, %r8d
               	shrxq	%rcx, %rax, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	$0x20, %ecx
               	jne	<addr>
               	xorl	%ecx, %ecx
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	popcntl	%esi, %ecx
               	movq	%rcx, %r9
               	andq	$0x1, %r9
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shrxq	%rcx, %rax, %r8
               	andq	$0x1, %r8
               	addq	%r8, %rdx
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	movq	%rdx, %rcx
               	andq	$0x1, %rcx
               	cmpl	%ecx, %r9d
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movq	%rdi, (%rcx)
               	movq	(%rcx), %rcx
               	movl	$0x3f, %r11d
               	bsrl	%ecx, %r8d
               	cmovel	%r11d, %r8d
               	xorl	$0x1f, %r8d
               	xorl	%ecx, %ecx
               	movl	$0x1f, %edx
               	subq	%rcx, %rdx
               	shrxq	%rdx, %rax, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movq	%rdi, (%rcx)
               	movq	(%rcx), %rcx
               	movl	$0x20, %r11d
               	bsfl	%ecx, %r8d
               	cmovel	%r11d, %r8d
               	xorl	%ecx, %ecx
               	shrxq	%rcx, %rax, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movq	%rdi, (%rcx)
               	movq	(%rcx), %rcx
               	popcntl	%ecx, %r8d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shrxq	%rcx, %rax, %rdi
               	andq	$0x1, %rdi
               	addq	%rdi, %rdx
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	%edx, %r8d
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3f, %r11d
               	bsrl	%esi, %ecx
               	cmovel	%r11d, %ecx
               	xorl	$0x1f, %ecx
               	leaq	-0x21(%rcx), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x1f, %edx
               	subq	%rcx, %rdx
               	shrxq	%rdx, %rax, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	subq	$0x21, %rcx
               	cmpl	%ecx, %edi
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rsi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	popcntl	%ecx, %r9d
               	movq	%rax, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shrxq	%rcx, %rdi, %r8
               	andq	$0x1, %r8
               	addq	%r8, %rdx
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rsi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movl	$0x3f, %r11d
               	bsrl	%ecx, %r8d
               	cmovel	%r11d, %r8d
               	xorl	$0x1f, %r8d
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	xorl	%ecx, %ecx
               	movl	$0x1f, %edi
               	subq	%rcx, %rdi
               	shrxq	%rdi, %rdx, %rdi
               	testb	$0x1, %dil
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3f, %r11d
               	bsrl	%esi, %ecx
               	cmovel	%r11d, %ecx
               	xorl	$0x1f, %ecx
               	imulq	$0xf4240, %rcx, %rcx    # imm = 0xF4240
               	movl	$0x20, %r11d
               	bsfl	%esi, %edx
               	cmovel	%r11d, %edx
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	addq	%rdx, %rcx
               	popcntl	%esi, %edx
               	leaq	(%rcx,%rdx), %rdi
               	xorl	%ecx, %ecx
               	movl	$0x1f, %edx
               	subq	%rcx, %rdx
               	shrxq	%rdx, %rax, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	imulq	$0xf4240, %rcx, %rsi    # imm = 0xF4240
               	xorl	%ecx, %ecx
               	shrxq	%rcx, %rax, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	leaq	(%rsi,%rcx), %r8
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shrxq	%rcx, %rax, %rsi
               	andq	$0x1, %rsi
               	addq	%rsi, %rdx
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	movslq	%edx, %rax
               	addq	%r8, %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x1d, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	incq	%rcx
               	jmp	<addr>

<check64>:
               	leaq	<rip>, %rax      # <addr>
               	movq	%rdi, (%rax)
               	movq	(%rax), %rdx
               	movq	%rdi, (%rax)
               	movq	(%rax), %r8
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
               	bsfq	%r8, %rcx
               	cmovel	%r11d, %ecx
               	xorl	%eax, %eax
               	cmpl	$0x40, %ecx
               	leaq	0x1(%rcx), %rsi
               	cmovel	%eax, %esi
               	shrxq	%rax, %rdi, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	$0x40, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	cmpl	%eax, %esi
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
               	movq	%rcx, %rax
               	andq	$0x1, %rax
               	cmpl	%eax, %r8d
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
               	incq	%rax
               	jmp	<addr>

<check_long>:
               	leaq	<rip>, %rax      # <addr>
               	movq	%rdi, (%rax)
               	movq	(%rax), %rsi
               	movq	%rdi, (%rax)
               	movq	(%rax), %r8
               	movl	$0x7f, %r11d
               	bsrq	%rsi, %rdx
               	cmovel	%r11d, %edx
               	xorl	$0x3f, %edx
               	xorl	%eax, %eax
               	movl	$0x3f, %ecx
               	subq	%rax, %rcx
               	shrxq	%rcx, %rdi, %rcx
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
               	movl	$0x3e, %edx
               	subq	%rax, %rdx
               	shrxq	%rdx, %rdi, %rdx
               	andq	$0x1, %rdx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3f, %eax
               	jl	<addr>
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movl	$0x40, %r11d
               	bsfq	%r8, %rcx
               	cmovel	%r11d, %ecx
               	xorl	%eax, %eax
               	cmpl	$0x40, %ecx
               	leaq	0x1(%rcx), %rdx
               	cmovel	%eax, %edx
               	shrxq	%rax, %rdi, %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	$0x40, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	popcntq	%rsi, %rax
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
               	movq	%rcx, %rax
               	andq	$0x1, %rax
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	incq	%rax
               	jmp	<addr>

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
               	xorl	%r12d, %r12d
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x40, %r12d
               	jge	<addr>
               	movl	$0x1, %eax
               	shlxq	%r12, %rax, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x1(%rbx), %r13
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
               	movq	%rbx, %r13
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
               	orq	%r11, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	incq	%r12
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%ebx, %ebx
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0xa, %ebx
               	jae	<addr>
               	leaq	<rip>, %rax       # <addr>
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
               	incq	%rbx
               	testl	%eax, %eax
               	je	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x1, %eax
               	shlxq	%rsi, %rax, %rcx
               	leaq	<rip>, %rax      # <addr>
               	movq	%rcx, (%rax)
               	movq	(%rax), %rdi
               	movl	%edi, %eax
               	movq	%rax, %rcx
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
               	movl	%edi, %eax
               	movq	%rax, %rcx
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
               	shrxq	%rax, %rdx, %rsi
               	leaq	<rip>, %rdx      # <addr>
               	movq	%rsi, (%rdx)
               	movq	(%rdx), %rdx
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
