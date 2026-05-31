
unary_plus_preserves_float.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003b6 <.text+0x136>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100e8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe3e(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400305 <.text+0x85>
               	leaq	0xfe1d(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	0xfdfd(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdee(%rip), %rdi      # 0x410116
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfde0(%rip), %rdi      # 0x41011d
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400a57 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400387 <.text+0x107>
               	leaq	0xfd86(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x400387 <.text+0x107>
               	leaq	0xfd6a(%rip), %r12      # 0x4100f8
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movabsq	$0x3ff8000000000000, %r11 # imm = 0x3FF8000000000000
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %r9
               	movabsq	$0x3fe0000000000000, %r11 # imm = 0x3FE0000000000000
               	movq	%r9, %xmm7
               	movq	%r11, %xmm15
               	addsd	%xmm15, %xmm7
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x40042e <.text+0x1ae>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %r9
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm7
               	movq	%r9, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%r9b
               	movzbq	%r9b, %r9
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x400495 <.text+0x215>
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x38(%rbp)
               	jmp	0x4004a8 <.text+0x228>
               	movabsq	$0x3fe0000000000000, %r9 # imm = 0x3FE0000000000000
               	movq	%r9, -0x38(%rbp)
               	jmp	0x4004a8 <.text+0x228>
               	movq	-0x38(%rbp), %r9
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x4004f3 <.text+0x273>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %r8
               	movq	%r8, %xmm7
               	movq	%r9, %xmm15
               	addsd	%xmm15, %xmm7
               	movabsq	$0x4000000000000000, %r8 # imm = 0x4000000000000000
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x400548 <.text+0x2c8>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %r9
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm7
               	movq	%r9, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4005af <.text+0x32f>
               	movabsq	$0x3fe0000000000000, %r8 # imm = 0x3FE0000000000000
               	movq	%r8, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x40(%rbp)
               	jmp	0x4005c2 <.text+0x342>
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, -0x40(%rbp)
               	jmp	0x4005c2 <.text+0x342>
               	movq	-0x40(%rbp), %rax
               	movq	%r9, %xmm7
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm7
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x400617 <.text+0x397>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %r9
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm7
               	movq	%r9, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40067e <.text+0x3fe>
               	movabsq	$0x3fe0000000000000, %r8 # imm = 0x3FE0000000000000
               	movq	%r8, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x48(%rbp)
               	jmp	0x400691 <.text+0x411>
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, -0x48(%rbp)
               	jmp	0x400691 <.text+0x411>
               	movq	-0x48(%rbp), %rax
               	movq	%r9, %xmm7
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm7
               	cvttsd2si	%xmm7, %rax
               	cmpq	$0x2, %rax
               	je	0x4006c8 <.text+0x448>
               	movl	$0x5, %r9d
               	movq	%r9, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	xorq	%r9, %r9
               	cvtsi2sd	%r9, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%r9b
               	movzbq	%r9b, %r9
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x40072f <.text+0x4af>
               	movabsq	$0x3fe0000000000000, %r8 # imm = 0x3FE0000000000000
               	movq	%r8, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x50(%rbp)
               	jmp	0x400742 <.text+0x4c2>
               	movabsq	$0x3fe0000000000000, %r9 # imm = 0x3FE0000000000000
               	movq	%r9, -0x50(%rbp)
               	jmp	0x400742 <.text+0x4c2>
               	movq	-0x50(%rbp), %r9
               	movq	%rax, %xmm7
               	movq	%r9, %xmm15
               	addsd	%xmm15, %xmm7
               	cvttsd2si	%xmm7, %r9
               	cvtsi2sd	%r9, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x20(%rbp)
               	movq	-0x20(%rbp), %r9
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x4007b3 <.text+0x533>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %r9 # imm = 0x3FF8000000000000
               	movq	%r9, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %r9
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm7
               	movq	%r9, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400846 <.text+0x5c6>
               	movabsq	$0x3fe0000000000000, %r8 # imm = 0x3FE0000000000000
               	movq	%r8, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x58(%rbp)
               	jmp	0x400859 <.text+0x5d9>
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, -0x58(%rbp)
               	jmp	0x400859 <.text+0x5d9>
               	movq	-0x58(%rbp), %rax
               	movq	%r9, %xmm7
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm7
               	cvttsd2si	%xmm7, %rax
               	cvtsi2sd	%rax, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	movabsq	$0x4000000000000000, %r9 # imm = 0x4000000000000000
               	movq	%r9, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4008e2 <.text+0x662>
               	movl	$0x7, %r9d
               	movq	%r9, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	0x400909 <.text+0x689>
               	movl	$0x8, %r9d
               	movq	%r9, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
