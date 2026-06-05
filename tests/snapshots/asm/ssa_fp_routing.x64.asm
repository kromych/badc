
ssa_fp_routing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsd	0x10(%rbp,%riz), %xmm0
               	movsd	0x20(%rbp,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsd	0x10(%rbp,%riz), %xmm0
               	movsd	0x20(%rbp,%riz), %xmm1
               	subsd	%xmm1, %xmm0
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsd	0x10(%rbp,%riz), %xmm0
               	movsd	0x20(%rbp,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsd	0x10(%rbp,%riz), %xmm0
               	movsd	0x20(%rbp,%riz), %xmm1
               	divsd	%xmm1, %xmm0
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsd	0x10(%rbp,%riz), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsd	0x10(%rbp,%riz), %xmm0
               	movsd	0x20(%rbp,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsd	0x10(%rbp,%riz), %xmm0
               	movsd	0x20(%rbp,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsd	0x10(%rbp,%riz), %xmm0
               	movsd	0x20(%rbp,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsd	0x10(%rbp,%riz), %xmm0
               	movsd	0x20(%rbp,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsd	0x10(%rbp,%riz), %xmm0
               	movsd	0x20(%rbp,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsd	0x10(%rbp,%riz), %xmm0
               	movsd	0x20(%rbp,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setae	%al
               	movzbq	%al, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	cvtsi2sd	%rax, %xmm0
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsd	0x10(%rbp,%riz), %xmm0
               	cvttsd2si	%xmm0, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	0x10(%rbp,%riz), %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	leaq	-0x8(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x170, %rsp            # imm = 0x170
               	movq	%rbx, (%rsp)
               	movabsq	$0x3ff8000000000000, %rdi # imm = 0x3FF8000000000000
               	movabsq	$0x4002000000000000, %rsi # imm = 0x4002000000000000
               	callq	<addr>
               	movabsq	$0x400e000000000000, %rax # imm = 0x400E000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x4014000000000000, %rdi # imm = 0x4014000000000000
               	movabsq	$0x3ff8000000000000, %rsi # imm = 0x3FF8000000000000
               	callq	<addr>
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x4004000000000000, %rdi # imm = 0x4004000000000000
               	movabsq	$0x4010000000000000, %rsi # imm = 0x4010000000000000
               	callq	<addr>
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x402e000000000000, %rdi # imm = 0x402E000000000000
               	movabsq	$0x4010000000000000, %rsi # imm = 0x4010000000000000
               	callq	<addr>
               	movabsq	$0x400e000000000000, %rax # imm = 0x400E000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x4004000000000000, %rbx # imm = 0x4004000000000000
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rbx, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x401c000000000000, %rbx # imm = 0x401C000000000000
               	movq	%rbx, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x60(%rbp)
               	movq	-0x60(%rbp), %rdi
               	callq	<addr>
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movq	%rdi, %rsi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movq	%rdi, %rsi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movabsq	$0x3ff0000000000000, %rsi # imm = 0x3FF0000000000000
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movabsq	$0x3ff0000000000000, %rsi # imm = 0x3FF0000000000000
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movq	%rdi, %rsi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x10, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movabsq	$0x3ff0000000000000, %rsi # imm = 0x3FF0000000000000
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movq	%rdi, %rsi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x12, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movabsq	$0x3ff0000000000000, %rsi # imm = 0x3FF0000000000000
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x13, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x4045000000000000, %rax # imm = 0x4045000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$-0x3, %rax
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x400e000000000000, %rdi # imm = 0x400E000000000000
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x400e000000000000, %rax # imm = 0x400E000000000000
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x150(%rbp)
               	movq	-0x150(%rbp), %rdi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x3fb999999999999a, %rbx # imm = 0x3FB999999999999A
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
