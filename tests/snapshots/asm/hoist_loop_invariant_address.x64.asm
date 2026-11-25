
hoist_loop_invariant_address.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x18, %rsp
               	xorl	%r9d, %r9d
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x900000004, %rax      # imm = 0x900000004
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x1900000010, %rax     # imm = 0x1900000010
               	movq	%rax, <rip> # <addr>
               	movl	$0x24, <rip> # <addr>
               	movl	$0x31, <rip> # <addr>
               	movabsq	$0x5100000040, %rax     # imm = 0x5100000040
               	movq	%rax, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	movq	$0x3b9aca07, <rip> # imm = 0x3B9ACA07
                                                # <addr>
               	movq	$0x7735940e, <rip> # imm = 0x7735940E
                                                # <addr>
               	movl	$0xb2d05e15, %eax       # imm = 0xB2D05E15
               	movq	%rax, <rip> # <addr>
               	movl	$0xee6b281c, %eax       # imm = 0xEE6B281C
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x12a05f223, %rax      # imm = 0x12A05F223
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x165a0bc2a, %rax      # imm = 0x165A0BC2A
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x1a13b8631, %rax      # imm = 0x1A13B8631
               	movq	%rax, <rip> # <addr>
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rcx, %rdx
               	incq	%rax
               	movl	%eax, (%rdx)
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rcx, %rsi
               	xorl	%edi, %edi
               	cmpl	$0x18, %eax
               	cmovgeq	%rdi, %rsi
               	movq	%rsi, 0x8(%rdx)
               	nopw	(%rax,%rax)
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorl	%esi, %esi
               	leaq	<rip>, %rdi # <addr>
               	xorl	%ecx, %ecx
               	movq	%rsi, %rax
               	testl	%eax, %eax
               	jle	<addr>
               	imulq	$0x1999999a, %rax, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	imulq	$0xa, %rdx, %r8
               	subq	%r8, %rax
               	movl	(%rdi,%rax,4), %eax
               	addq	%rax, %rcx
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	movslq	%ecx, %rax
               	addq	%rax, %r9
               	incq	%rsi
               	cmpl	$0x1f4, %esi            # imm = 0x1F4
               	jl	<addr>
               	cmpq	$0x7b0c, %r9            # imm = 0x7B0C
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%r9, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %r8 # <addr>
               	xorl	%r10d, %r10d
               	movq	%r10, %rsi
               	xorl	%ecx, %ecx
               	movq	(%r8,%rcx,8), %rdi
               	movabsq	$-0x768fa0ceed5d701b, %r9 # imm = 0x89705F3112A28FE5
               	movq	%rdi, %rax
               	imulq	%r9
               	leaq	(%rdx,%rdi), %rax
               	sarq	$0x1d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	addq	%rax, %rsi
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jle	<addr>
               	incq	%r10
               	cmpl	$0x3, %r10d
               	jl	<addr>
               	cmpq	$0x1e, %rsi
               	je	<addr>
               	leaq	<rip>, %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	<rip>, %r8 # <addr>
               	xorl	%r10d, %r10d
               	movq	%r10, %rsi
               	xorl	%ecx, %ecx
               	movq	(%r8,%rcx,8), %rdi
               	movabsq	$-0x768fa0ceed5d701b, %r9 # imm = 0x89705F3112A28FE5
               	movq	%rdi, %rax
               	imulq	%r9
               	leaq	(%rdx,%rdi), %rax
               	sarq	$0x1d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	addq	%rax, %rsi
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jle	<addr>
               	incq	%r10
               	cmpl	$0x3, %r10d
               	jl	<addr>
               	movq	0x8(%rsp), %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax # <addr>
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
               	leaq	<rip>, %rax # <addr>
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
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	incq	%rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	<rip>, %esi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	movl	%eax, <rip> # <addr>
               	movq	%rax, %rcx
               	movslq	<rip>, %rdx # <addr>
               	addq	%rdx, %rcx
               	movl	<rip>, %edx # <addr>
               	addq	$0x2, %rdx
               	movl	%edx, <rip> # <addr>
               	incq	%rax
               	cmpl	$0x64, %eax
               	jl	<addr>
               	cmpq	$0x26ac, %rcx           # imm = 0x26AC
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xc8, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	<rip>, %esi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	xorps	%xmm0, %xmm0
               	movl	$0x3f804000, (%rcx,%rax,4) # imm = 0x3F804000
               	vaddss	(%rcx,%rax,4), %xmm0, %xmm0
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	xorps	%xmm0, %xmm0
               	movl	$0x3f804000, (%rcx,%rax,4) # imm = 0x3F804000
               	vaddss	(%rcx,%rax,4), %xmm0, %xmm0
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rsi, %rdi
               	movb	$0x2, %al
               	callq	<addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, <rip> # <addr>
               	movq	<rip>, %rdx # <addr>
               	movl	(%rdx), %esi
               	leaq	0x1(%rax), %rcx
               	addq	%rsi, %rax
               	cmpl	$0xc, %eax
               	jg	<addr>
               	movq	%rcx, %rax
               	movl	(%rdx), %esi
               	leaq	0x1(%rax), %rcx
               	addq	%rsi, %rax
               	nop
               	cmpl	$0xc, %eax
               	jle	<addr>
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, <rip> # <addr>
               	movslq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	addq	$0x4, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	%rax, %rcx
               	movl	(%rdx), %esi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0x3c, %ecx
               	je	<addr>
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movl	(%rcx), %edx
               	leaq	0x1(%rax), %rsi
               	addq	%rdx, %rax
               	cmpl	$0xc, %eax
               	jg	<addr>
               	movq	%rsi, %rax
               	movl	(%rcx), %edx
               	leaq	0x1(%rax), %rsi
               	addq	%rdx, %rax
               	cmpl	$0xc, %eax
               	jle	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, <rip> # <addr>
               	movslq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	addq	$0x4, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rax, %rdx
               	movl	(%rcx), %r8d
               	addq	%r8, %rdx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x18, %rsp
               	retq
