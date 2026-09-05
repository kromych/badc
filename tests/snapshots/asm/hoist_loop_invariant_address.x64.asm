
hoist_loop_invariant_address.x64:	file format elf64-x86-64

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

<setup>:
               	leaq	<rip>, %rax
               	leaq	(%rax), %rcx
               	xorq	%rax, %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x1, %edx
               	movl	%edx, 0x4(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x4, %edx
               	movl	%edx, 0x8(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x9, %edx
               	movl	%edx, 0xc(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x10, %edx
               	movl	%edx, 0x10(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x19, %edx
               	movl	%edx, 0x14(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x24, %edx
               	movl	%edx, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x31, %edx
               	movl	%edx, 0x1c(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x40, %edx
               	movl	%edx, 0x20(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x51, %edx
               	movl	%edx, 0x24(%rcx)
               	leaq	<rip>, %rcx
               	addq	$0x0, %rcx
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x3b9aca07, %edx       # imm = 0x3B9ACA07
               	movq	%rdx, 0x8(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x7735940e, %edx       # imm = 0x7735940E
               	movq	%rdx, 0x10(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0xb2d05e15, %edx       # imm = 0xB2D05E15
               	movq	%rdx, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0xee6b281c, %edx       # imm = 0xEE6B281C
               	movq	%rdx, 0x20(%rcx)
               	leaq	<rip>, %rcx
               	movabsq	$0x12a05f223, %rdx      # imm = 0x12A05F223
               	movq	%rdx, 0x28(%rcx)
               	leaq	<rip>, %rcx
               	movabsq	$0x165a0bc2a, %rdx      # imm = 0x165A0BC2A
               	movq	%rdx, 0x30(%rcx)
               	leaq	<rip>, %rcx
               	movabsq	$0x1a13b8631, %rdx      # imm = 0x1A13B8631
               	movq	%rdx, 0x38(%rcx)
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	leaq	(%rsi,%r8), %rdi
               	leaq	0x1(%rdx), %rcx
               	movl	%ecx, (%rdi)
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	shlq	$0x4, %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, 0x8(%rdi)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	callq	<addr>
               	leaq	<rip>, %rdx
               	movq	%rbx, %r8
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movq	%rbx, %rax
               	jmp	<addr>
               	movslq	%eax, %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	imulq	$0xa, %rax, %rdi
               	subq	%rdi, %rsi
               	movslq	(%rdx,%rsi,4), %rsi
               	addq	%rsi, %rcx
               	testl	%eax, %eax
               	jg	<addr>
               	movslq	%ecx, %rax
               	addq	%rax, %r8
               	incq	%rbx
               	cmpl	$0x1f4, %ebx            # imm = 0x1F4
               	jl	<addr>
               	cmpq	$0x7b0c, %r8            # imm = 0x7B0C
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%r8, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rdx
               	xorq	%r8, %r8
               	movq	%r8, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	cmpq	$0x4, %rax
               	jg	<addr>
               	movq	%rax, %rsi
               	andq	$0x7, %rsi
               	movslq	%esi, %rsi
               	movq	(%rdx,%rsi,8), %rsi
               	movabsq	$-0x768fa0ceed5d701b, %rdi # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	imulq	%rdi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	addq	%rdi, %rsi
               	sarq	$0x1d, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpq	$0x2dc6c0, %rax         # imm = 0x2DC6C0
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x3, %r8d
               	jl	<addr>
               	cmpq	$0x1e, %rcx
               	je	<addr>
               	leaq	<rip>, %r9
               	leaq	<rip>, %rdx
               	xorq	%r8, %r8
               	movq	%r8, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	cmpq	$0x4, %rax
               	jg	<addr>
               	movq	%rax, %rsi
               	andq	$0x7, %rsi
               	movslq	%esi, %rsi
               	movq	(%rdx,%rsi,8), %rsi
               	movabsq	$-0x768fa0ceed5d701b, %rdi # imm = 0x89705F3112A28FE5
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	imulq	%rdi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	addq	%rdi, %rsi
               	sarq	$0x1d, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpq	$0x2dc6c0, %rax         # imm = 0x2DC6C0
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x3, %r8d
               	jl	<addr>
               	movq	%r9, %rdi
               	movq	%rcx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rax
               	jmp	<addr>
               	movslq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x12c, %rcx            # imm = 0x12C
               	je	<addr>
               	leaq	<rip>, %rsi
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rax
               	jmp	<addr>
               	movslq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rsi, %rdi
               	movq	%rcx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	incq	%rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	(%rcx), %rsi
               	addq	%rsi, %rdx
               	movslq	(%rcx), %rsi
               	addq	$0x2, %rsi
               	movl	%esi, (%rcx)
               	incq	%rax
               	cmpl	$0x64, %eax
               	jl	<addr>
               	cmpq	$0x26ac, %rdx           # imm = 0x26AC
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xc8, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x8(%rbp,%riz)
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	movl	$0x3f804000, %r8d       # imm = 0x3F804000
               	movq	%r8, %xmm14
               	movss	%xmm14, (%rdi,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	movss	(%rdi,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movss	-0x8(%rbp,%riz), %xmm0
               	movl	$0x41804000, %eax       # imm = 0x41804000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movss	0x3c(%rax,%riz), %xmm0
               	movl	$0x3f804000, %eax       # imm = 0x3F804000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %r9
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x8(%rbp,%riz)
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	movl	$0x3f804000, %r8d       # imm = 0x3F804000
               	movq	%r8, %xmm14
               	movss	%xmm14, (%rdi,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	movss	(%rdi,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movss	-0x8(%rbp,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	leaq	<rip>, %rax
               	movss	0x3c(%rax,%riz), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%r9, %rdi
               	movb	$0x2, %al
               	callq	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
