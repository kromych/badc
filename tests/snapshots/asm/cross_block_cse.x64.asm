
cross_block_cse.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x28(%rbp), %rax
               	leaq	(%rax), %rcx
               	xorq	%rdx, %rdx
               	movl	%edx, (%rcx)
               	movl	$0x1, %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	$0x4, %ecx
               	movl	%ecx, 0x8(%rax)
               	movl	$0x9, %ecx
               	movl	%ecx, 0xc(%rax)
               	movl	$0x10, %ecx
               	movl	%ecx, 0x10(%rax)
               	movl	$0x19, %ecx
               	movl	%ecx, 0x14(%rax)
               	movl	$0x24, %ecx
               	movl	%ecx, 0x18(%rax)
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x31, %eax
               	movl	%eax, 0x1c(%rdi)
               	movl	$0x40, %eax
               	movl	%eax, 0x20(%rdi)
               	movl	$0x51, %eax
               	movl	%eax, 0x24(%rdi)
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	imulq	$0x66666667, %rcx, %r8  # imm = 0x66666667
               	movq	%r8, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rdx,%r9), %rbx
               	imulq	$0xa, %rbx, %r12
               	movq	%r12, %r10
               	movq	%rcx, %r12
               	subq	%r10, %r12
               	movslq	%r12d, %r12
               	movslq	(%rdi,%r12,4), %r12
               	addq	%r12, %rax
               	movslq	%eax, %r12
               	cmpq	$0xc8, %r12
               	jg	<addr>
               	movq	%rbx, %rsi
               	movslq	%esi, %rcx
               	testq	%rcx, %rcx
               	jg	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x7, %ecx
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0x66666667, %rdx, %r8  # imm = 0x66666667
               	movq	%r8, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rsi,%r9), %rbx
               	imulq	$0xa, %rbx, %r12
               	movq	%r12, %r10
               	movq	%rdx, %r12
               	subq	%r10, %r12
               	movslq	%r12d, %r12
               	movslq	(%rdi,%r12,4), %r12
               	addq	%r12, %rax
               	movslq	%eax, %r12
               	cmpq	$0xc8, %r12
               	jg	<addr>
               	movq	%rbx, %rcx
               	movslq	%ecx, %rdx
               	testq	%rdx, %rdx
               	jg	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x31, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x99, %ecx
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0x66666667, %rdx, %r8  # imm = 0x66666667
               	movq	%r8, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rsi,%r9), %rbx
               	imulq	$0xa, %rbx, %r12
               	movq	%r12, %r10
               	movq	%rdx, %r12
               	subq	%r10, %r12
               	movslq	%r12d, %r12
               	movslq	(%rdi,%r12,4), %r12
               	addq	%r12, %rax
               	movslq	%eax, %r12
               	cmpq	$0xc8, %r12
               	jg	<addr>
               	movq	%rbx, %rcx
               	movslq	%ecx, %rdx
               	testq	%rdx, %rdx
               	jg	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x23, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rdi
               	movl	$0xf423f, %ecx          # imm = 0xF423F
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0x66666667, %rdx, %r8  # imm = 0x66666667
               	movq	%r8, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	leaq	(%rsi,%r9), %rbx
               	imulq	$0xa, %rbx, %r12
               	movq	%r12, %r10
               	movq	%rdx, %r12
               	subq	%r10, %r12
               	movslq	%r12d, %r12
               	movslq	(%rdi,%r12,4), %r12
               	addq	%r12, %rax
               	movslq	%eax, %r12
               	cmpq	$0xc8, %r12
               	jg	<addr>
               	movq	%rbx, %rcx
               	movslq	%ecx, %rdx
               	testq	%rdx, %rdx
               	jg	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x21, %eax
               	movl	$0x40, %eax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0xc, %eax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm15
               	divsd	%xmm15, %xmm0
               	movabsq	$0x4018000000000000, %rdx # imm = 0x4018000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdx)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdx)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%rdx)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rsi
               	leaq	0x1(%rsi), %rdi
               	movq	(%rdx,%rax,8), %r8
               	testq	%r8, %r8
               	jle	<addr>
               	movq	(%rdx,%rax,8), %r8
               	movq	%r8, %rsi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rcx
               	jmp	<addr>
               	subq	%rdi, %rcx
               	jmp	<addr>
               	incq	%rax
               	cmpq	$0x6, %rax
               	jl	<addr>
               	cmpq	$0x42, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	movabsq	$0x43e0000000000000, %rax # imm = 0x43E0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	movl	$0x5f000000, %eax       # imm = 0x5F000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
