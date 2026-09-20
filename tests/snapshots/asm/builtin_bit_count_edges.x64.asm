
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
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	%rdi, (%rax)
               	movq	(%rax), %rsi
               	movq	%rdi, (%rax)
               	movq	(%rax), %rbx
               	movl	%edi, %eax
               	movl	$0x3f, %r11d
               	bsrl	%esi, %r9d
               	cmovel	%r11d, %r9d
               	xorl	$0x1f, %r9d
               	xorl	%edx, %edx
               	movl	$0x1f, %ecx
               	subq	%rdx, %rcx
               	movq	%rax, %r8
               	shrq	%cl, %r8
               	testb	$0x1, %r8b
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x20, %r11d
               	bsfl	%esi, %r8d
               	cmovel	%r11d, %r8d
               	xorl	%ecx, %ecx
               	movq	%rax, %rdx
               	shrq	%cl, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	popcntl	%esi, %r9d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movq	%rax, %r8
               	shrq	%cl, %r8
               	andq	$0x1, %r8
               	addq	%r8, %rdx
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	%ebx, %r11d
               	shll	%r11d
               	xorl	%ebx, %r11d
               	orl	$0x1, %r11d
               	bsrl	%r11d, %r12d
               	xorl	$0x1f, %r12d
               	movq	%rax, %r8
               	shrq	$0x1f, %r8
               	xorl	%edx, %edx
               	movl	$0x1e, %ecx
               	subq	%rdx, %rcx
               	movq	%rax, %r9
               	shrq	%cl, %r9
               	movq	%r9, %rcx
               	andq	$0x1, %rcx
               	cmpl	%r8d, %ecx
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x1f, %edx
               	jl	<addr>
               	cmpl	%edx, %r12d
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x20, %r11d
               	bsfl	%ebx, %ecx
               	cmovel	%r11d, %ecx
               	leaq	0x1(%rcx), %rdx
               	shrq	$0x5, %rcx
               	decq	%rcx
               	movq	%rdx, %r8
               	andq	%rcx, %r8
               	xorl	%ecx, %ecx
               	movq	%rax, %rdx
               	shrq	%cl, %rdx
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
               	popq	%r12
               	popq	%rbp
               	retq
               	popcntl	%esi, %ecx
               	movq	%rcx, %r9
               	andq	$0x1, %r9
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movq	%rax, %r8
               	shrq	%cl, %r8
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
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	%rdi, (%rcx)
               	movq	(%rcx), %rcx
               	movl	$0x3f, %r11d
               	bsrl	%ecx, %r9d
               	cmovel	%r11d, %r9d
               	xorl	$0x1f, %r9d
               	xorl	%edx, %edx
               	movl	$0x1f, %ecx
               	subq	%rdx, %rcx
               	movq	%rax, %r8
               	shrq	%cl, %r8
               	testb	$0x1, %r8b
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	%rdi, (%rcx)
               	movq	(%rcx), %rcx
               	movl	$0x20, %r11d
               	bsfl	%ecx, %r8d
               	cmovel	%r11d, %r8d
               	xorl	%ecx, %ecx
               	movq	%rax, %rdx
               	shrq	%cl, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	%rdi, (%rcx)
               	movq	(%rcx), %rcx
               	popcntl	%ecx, %r8d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movq	%rax, %rdi
               	shrq	%cl, %rdi
               	andq	$0x1, %rdi
               	addq	%rdi, %rdx
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	%edx, %r8d
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x3f, %r11d
               	bsrl	%esi, %ecx
               	cmovel	%r11d, %ecx
               	xorl	$0x1f, %ecx
               	leaq	-0x21(%rcx), %r8
               	xorl	%edx, %edx
               	movl	$0x1f, %ecx
               	subq	%rdx, %rcx
               	movq	%rax, %rdi
               	shrq	%cl, %rdi
               	testb	$0x1, %dil
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	leaq	-0x21(%rdx), %rcx
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rsi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	popcntl	%ecx, %r9d
               	movq	%rax, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movq	%rdi, %r8
               	shrq	%cl, %r8
               	andq	$0x1, %r8
               	addq	%r8, %rdx
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rsi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movl	$0x3f, %r11d
               	bsrl	%ecx, %r9d
               	cmovel	%r11d, %r9d
               	xorl	$0x1f, %r9d
               	movq	%rax, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	xorl	%edx, %edx
               	movl	$0x1f, %ecx
               	subq	%rdx, %rcx
               	movq	%rdi, %r8
               	shrq	%cl, %r8
               	testb	$0x1, %r8b
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
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
               	xorl	%edx, %edx
               	movl	$0x1f, %ecx
               	subq	%rdx, %rcx
               	movq	%rax, %rsi
               	shrq	%cl, %rsi
               	testb	$0x1, %sil
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x20, %edx
               	jl	<addr>
               	imulq	$0xf4240, %rdx, %rsi    # imm = 0xF4240
               	xorl	%ecx, %ecx
               	movq	%rax, %rdx
               	shrq	%cl, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	leaq	(%rsi,%rcx), %r8
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movq	%rax, %rsi
               	shrq	%cl, %rsi
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
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	incq	%rcx
               	jmp	<addr>

<check64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	%rdi, (%rax)
               	movq	(%rax), %rdx
               	movq	%rdi, (%rax)
               	movq	(%rax), %r9
               	movl	$0x7f, %r11d
               	bsrq	%rdx, %r8
               	cmovel	%r11d, %r8d
               	xorl	$0x3f, %r8d
               	xorl	%eax, %eax
               	movl	$0x3f, %ecx
               	subq	%rax, %rcx
               	movq	%rdi, %rsi
               	shrq	%cl, %rsi
               	testb	$0x1, %sil
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %r8d
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x40, %r11d
               	bsfq	%rdx, %rsi
               	cmovel	%r11d, %esi
               	xorl	%ecx, %ecx
               	movq	%rdi, %rax
               	shrq	%cl, %rax
               	testb	$0x1, %al
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	cmpl	%ecx, %esi
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	popcntq	%rdx, %r8
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rdi, %rsi
               	shrq	%cl, %rsi
               	andq	$0x1, %rsi
               	addq	%rsi, %rax
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	cmpl	%eax, %r8d
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%r9, %r11
               	shlq	%r11
               	xorq	%r9, %r11
               	orq	$0x1, %r11
               	bsrq	%r11, %rbx
               	xorl	$0x3f, %ebx
               	movq	%rdi, %rsi
               	shrq	$0x3f, %rsi
               	xorl	%eax, %eax
               	movl	$0x3e, %ecx
               	subq	%rax, %rcx
               	movq	%rdi, %r8
               	shrq	%cl, %r8
               	movq	%r8, %rcx
               	andq	$0x1, %rcx
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3f, %eax
               	jl	<addr>
               	cmpl	%eax, %ebx
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x40, %r11d
               	bsfq	%r9, %rax
               	cmovel	%r11d, %eax
               	leaq	0x1(%rax), %rcx
               	shrq	$0x6, %rax
               	decq	%rax
               	movq	%rcx, %rsi
               	andq	%rax, %rsi
               	xorl	%ecx, %ecx
               	movq	%rdi, %rax
               	shrq	%cl, %rax
               	testb	$0x1, %al
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	xorl	%eax, %eax
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	popcntq	%rdx, %rax
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rdi, %rsi
               	shrq	%cl, %rsi
               	andq	$0x1, %rsi
               	addq	%rsi, %rax
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	andq	$0x1, %rax
               	cmpl	%eax, %r8d
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x40, %r11d
               	bsfq	%rdx, %rax
               	cmovel	%r11d, %eax
               	leaq	-0x41(%rax), %rsi
               	xorl	%ecx, %ecx
               	movq	%rdi, %rax
               	shrq	%cl, %rax
               	testb	$0x1, %al
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	leaq	-0x41(%rcx), %rax
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	%edx, %eax
               	popcntq	%rax, %r9
               	movl	%edi, %esi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rsi, %r8
               	shrq	%cl, %r8
               	andq	$0x1, %r8
               	addq	%r8, %rax
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x1b, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	orq	%rdx, %rax
               	movl	$0x7f, %r11d
               	bsrq	%rax, %r9
               	cmovel	%r11d, %r9d
               	xorl	$0x3f, %r9d
               	movabsq	$0x100000000, %rsi      # imm = 0x100000000
               	orq	%rdi, %rsi
               	xorl	%eax, %eax
               	movl	$0x3f, %ecx
               	subq	%rax, %rcx
               	movq	%rsi, %r8
               	shrq	%cl, %r8
               	testb	$0x1, %r8b
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x1c, %eax
               	popq	%rbx
               	leave
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
               	movq	%rdi, %rdx
               	shrq	%cl, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	imulq	$0xf4240, %rax, %rdx    # imm = 0xF4240
               	xorl	%ecx, %ecx
               	movq	%rdi, %rax
               	shrq	%cl, %rax
               	testb	$0x1, %al
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	imulq	$0x3e8, %rcx, %rax      # imm = 0x3E8
               	leaq	(%rdx,%rax), %r8
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rdi, %rdx
               	shrq	%cl, %rdx
               	andq	$0x1, %rdx
               	addq	%rdx, %rax
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	movslq	%eax, %rax
               	addq	%r8, %rax
               	cmpq	%rax, %rsi
               	je	<addr>
               	movl	$0x1e, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x1(%rcx), %rax
               	jmp	<addr>

<check_long>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	%rdi, (%rax)
               	movq	(%rax), %r8
               	movq	%rdi, (%rax)
               	movq	(%rax), %r9
               	movl	$0x7f, %r11d
               	bsrq	%r8, %rsi
               	cmovel	%r11d, %esi
               	xorl	$0x3f, %esi
               	xorl	%eax, %eax
               	movl	$0x3f, %ecx
               	subq	%rax, %rcx
               	movq	%rdi, %rdx
               	shrq	%cl, %rdx
               	testb	$0x1, %dl
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x40, %r11d
               	bsfq	%r8, %rdx
               	cmovel	%r11d, %edx
               	xorl	%ecx, %ecx
               	movq	%rdi, %rax
               	shrq	%cl, %rax
               	testb	$0x1, %al
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	cmpl	%ecx, %edx
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	leave
               	retq
               	popcntq	%r8, %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rdi, %rdx
               	shrq	%cl, %rdx
               	andq	$0x1, %rdx
               	addq	%rdx, %rax
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%r9, %r11
               	shlq	%r11
               	xorq	%r9, %r11
               	orq	$0x1, %r11
               	bsrq	%r11, %rbx
               	xorl	$0x3f, %ebx
               	movq	%rdi, %rdx
               	shrq	$0x3f, %rdx
               	xorl	%eax, %eax
               	movl	$0x3e, %ecx
               	subq	%rax, %rcx
               	movq	%rdi, %rsi
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	andq	$0x1, %rcx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3f, %eax
               	jl	<addr>
               	cmpl	%eax, %ebx
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x40, %r11d
               	bsfq	%r9, %rax
               	cmovel	%r11d, %eax
               	leaq	0x1(%rax), %rcx
               	shrq	$0x6, %rax
               	decq	%rax
               	movq	%rcx, %rdx
               	andq	%rax, %rdx
               	xorl	%ecx, %ecx
               	movq	%rdi, %rax
               	shrq	%cl, %rax
               	testb	$0x1, %al
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	xorl	%eax, %eax
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	leave
               	retq
               	popcntq	%r8, %rax
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rdi, %rdx
               	shrq	%cl, %rdx
               	andq	$0x1, %rdx
               	addq	%rdx, %rax
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	andq	$0x1, %rax
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x1(%rcx), %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
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
               	movq	$-0x1, %rbx
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
               	xorl	%r12d, %r12d
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x40, %r12d
               	jge	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rbx
               	movq	%r12, %rcx
               	shlq	%cl, %rbx
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
               	leaq	<rip>, %rax
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
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	$-0x1, %rdx
               	movq	%rdx, %rsi
               	shrq	%cl, %rsi
               	leaq	<rip>, %rdx
               	movq	%rsi, (%rdx)
               	movq	(%rdx), %rdx
               	popcntq	%rdx, %rdx
               	addq	%rdx, %rax
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	cmpq	$0x820, %rax            # imm = 0x820
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
