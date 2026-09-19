
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
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x1, 0x4(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x4, 0x8(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x9, 0xc(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x10, 0x10(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x19, 0x14(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x24, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x31, 0x1c(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x40, 0x20(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x51, 0x24(%rcx)
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rcx
               	movq	$0x3b9aca07, 0x8(%rcx)  # imm = 0x3B9ACA07
               	leaq	<rip>, %rcx
               	movq	$0x7735940e, 0x10(%rcx) # imm = 0x7735940E
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
               	leaq	<rip>, %rdx
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movq	%rax, %rdi
               	shlq	$0x4, %rdi
               	leaq	(%rdx,%rdi), %rsi
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, (%rsi)
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdx, %rdi
               	jmp	<addr>
               	xorl	%edi, %edi
               	movq	%rdi, 0x8(%rsi)
               	movq	%rcx, %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	callq	<addr>
               	leaq	<rip>, %rdx
               	movq	%rbx, %r8
               	cmpl	$0x1f4, %ebx            # imm = 0x1F4
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movq	%rbx, %rax
               	testl	%eax, %eax
               	jle	<addr>
               	imulq	$0x1999999a, %rax, %rsi # imm = 0x1999999A
               	shrq	$0x20, %rsi
               	imulq	$0xa, %rsi, %rdi
               	subq	%rdi, %rax
               	movslq	(%rdx,%rax,4), %rax
               	addq	%rax, %rcx
               	movq	%rsi, %rax
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
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdx
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	cmpl	$0x3, %r8d
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x4, %eax
               	jg	<addr>
               	movq	(%rdx,%rax,8), %rsi
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
               	cmpl	$0x4, %eax
               	jle	<addr>
               	incq	%r8
               	cmpl	$0x3, %r8d
               	jl	<addr>
               	cmpq	$0x1e, %rcx
               	je	<addr>
               	leaq	<rip>, %r9
               	leaq	<rip>, %rdx
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	cmpl	$0x3, %r8d
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x4, %eax
               	jg	<addr>
               	movq	(%rdx,%rax,8), %rsi
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
               	cmpl	$0x4, %eax
               	jle	<addr>
               	incq	%r8
               	cmpl	$0x3, %r8d
               	jl	<addr>
               	movq	%r9, %rdi
               	movq	%rcx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x12c, %rcx            # imm = 0x12C
               	je	<addr>
               	leaq	<rip>, %rsi
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jge	<addr>
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	incq	%rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movq	%rax, %rdx
               	cmpl	$0x64, %eax
               	jge	<addr>
               	movslq	(%rcx), %rsi
               	addq	%rsi, %rdx
               	movslq	(%rcx), %rsi
               	addq	$0x2, %rsi
               	movl	%esi, (%rcx)
               	incq	%rax
               	cmpl	$0x64, %eax
               	jl	<addr>
               	cmpq	$0x26ac, %rdx           # imm = 0x26AC
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xc8, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edx, %edx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movl	$0x3f804000, (%rsi)     # imm = 0x3F804000
               	movss	(%rsi,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x41804000, %eax       # imm = 0x41804000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax
               	movss	0x3c(%rax,%riz), %xmm0
               	movl	$0x3f804000, %eax       # imm = 0x3F804000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %r8
               	xorl	%edx, %edx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movl	$0x3f804000, (%rsi)     # imm = 0x3F804000
               	movss	(%rsi,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	leaq	<rip>, %rax
               	movss	0x3c(%rax,%riz), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%r8, %rdi
               	movb	$0x2, %al
               	callq	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
