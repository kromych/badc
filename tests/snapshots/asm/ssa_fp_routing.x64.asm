
ssa_fp_routing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400581 <.text+0x301>
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
               	callq	0x401107 <dlsym>
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
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%r11, %xmm0
               	movq	%r9, %xmm15
               	addsd	%xmm15, %xmm0
               	movq	%xmm0, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%r11, %xmm0
               	movq	%r9, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%xmm0, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%r11, %xmm0
               	movq	%r9, %xmm15
               	mulsd	%xmm15, %xmm0
               	movq	%xmm0, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%r11, %xmm0
               	movq	%r9, %xmm15
               	divsd	%xmm15, %xmm0
               	movq	%xmm0, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%r11, %xmm0
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%xmm0, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%r11, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%r11, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%r11, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%r11, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%al
               	movzbq	%al, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%r11, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%r11, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%al
               	movzbq	%al, %rax
               	retq
               	movslq	%edi, %r11
               	cvtsi2sd	%r11, %xmm0
               	movq	%xmm0, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%r11, %xmm14
               	cvttsd2si	%xmm14, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	leaq	-0x8(%rbp), %r9
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x180, %rsp            # imm = 0x180
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movabsq	$0x3ff8000000000000, %rbx # imm = 0x3FF8000000000000
               	movabsq	$0x4002000000000000, %r12 # imm = 0x4002000000000000
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x4003b6 <.text+0x136>
               	movabsq	$0x400e000000000000, %r12 # imm = 0x400E000000000000
               	movq	%rax, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40061f <.text+0x39f>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x4014000000000000, %r14 # imm = 0x4014000000000000
               	movabsq	$0x3ff8000000000000, %r15 # imm = 0x3FF8000000000000
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	callq	0x4003d1 <.text+0x151>
               	movabsq	$0x400c000000000000, %r15 # imm = 0x400C000000000000
               	movq	%rax, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40069f <.text+0x41f>
               	movl	$0x2, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x4004000000000000, %rbx # imm = 0x4004000000000000
               	movabsq	$0x4010000000000000, %r12 # imm = 0x4010000000000000
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x4003ec <.text+0x16c>
               	movabsq	$0x4024000000000000, %r12 # imm = 0x4024000000000000
               	movq	%rax, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40071f <.text+0x49f>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x402e000000000000, %r14 # imm = 0x402E000000000000
               	movabsq	$0x4010000000000000, %r15 # imm = 0x4010000000000000
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	callq	0x400407 <.text+0x187>
               	movabsq	$0x400e000000000000, %r15 # imm = 0x400E000000000000
               	movq	%rax, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40079f <.text+0x51f>
               	movl	$0x4, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x4004000000000000, %rbx # imm = 0x4004000000000000
               	movq	%rbx, %rdi
               	callq	0x400422 <.text+0x1a2>
               	movq	%rbx, %xmm7
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
               	je	0x40081b <.text+0x59b>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x401c000000000000, %r15 # imm = 0x401C000000000000
               	movq	%r15, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x60(%rbp)
               	movq	-0x60(%rbp), %r12
               	movq	%r12, %rdi
               	callq	0x400422 <.text+0x1a2>
               	movq	%rax, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4008aa <.text+0x62a>
               	movl	$0x6, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r14 # imm = 0x3FF0000000000000
               	movq	%r14, %rdi
               	movq	%r14, %rsi
               	callq	0x400444 <.text+0x1c4>
               	cmpq	$0x0, %rax
               	jne	0x4008f4 <.text+0x674>
               	movl	$0x7, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r15 # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	callq	0x400444 <.text+0x1c4>
               	cmpq	$0x0, %rax
               	je	0x400947 <.text+0x6c7>
               	movl	$0x8, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r12 # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %r14 # imm = 0x4000000000000000
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	0x40046d <.text+0x1ed>
               	cmpq	$0x0, %rax
               	jne	0x40099b <.text+0x71b>
               	movl	$0x9, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r15 # imm = 0x3FF0000000000000
               	movq	%r15, %rdi
               	movq	%r15, %rsi
               	callq	0x40046d <.text+0x1ed>
               	cmpq	$0x0, %rax
               	je	0x4009e5 <.text+0x765>
               	movl	$0xa, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r14 # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	0x400496 <.text+0x216>
               	cmpq	$0x0, %rax
               	jne	0x400a38 <.text+0x7b8>
               	movl	$0xb, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %r12 # imm = 0x4000000000000000
               	movabsq	$0x3ff0000000000000, %r15 # imm = 0x3FF0000000000000
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	callq	0x400496 <.text+0x216>
               	cmpq	$0x0, %rax
               	je	0x400a8c <.text+0x80c>
               	movl	$0xc, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %r14 # imm = 0x4000000000000000
               	movabsq	$0x3ff0000000000000, %rbx # imm = 0x3FF0000000000000
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	0x4004bf <.text+0x23f>
               	cmpq	$0x0, %rax
               	jne	0x400adf <.text+0x85f>
               	movl	$0xd, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r12 # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %r15 # imm = 0x4000000000000000
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	callq	0x4004bf <.text+0x23f>
               	cmpq	$0x0, %rax
               	je	0x400b33 <.text+0x8b3>
               	movl	$0xe, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r14 # imm = 0x3FF0000000000000
               	movq	%r14, %rdi
               	movq	%r14, %rsi
               	callq	0x4004dd <.text+0x25d>
               	cmpq	$0x0, %rax
               	jne	0x400b7d <.text+0x8fd>
               	movl	$0xf, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r15 # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	callq	0x4004dd <.text+0x25d>
               	cmpq	$0x0, %rax
               	jne	0x400bd0 <.text+0x950>
               	movl	$0x10, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %r12 # imm = 0x4000000000000000
               	movabsq	$0x3ff0000000000000, %r14 # imm = 0x3FF0000000000000
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	0x4004dd <.text+0x25d>
               	cmpq	$0x0, %rax
               	je	0x400c24 <.text+0x9a4>
               	movl	$0x11, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r15 # imm = 0x3FF0000000000000
               	movq	%r15, %rdi
               	movq	%r15, %rsi
               	callq	0x400506 <.text+0x286>
               	cmpq	$0x0, %rax
               	jne	0x400c6e <.text+0x9ee>
               	movl	$0x12, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %r14 # imm = 0x4000000000000000
               	movabsq	$0x3ff0000000000000, %rbx # imm = 0x3FF0000000000000
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	0x400506 <.text+0x286>
               	cmpq	$0x0, %rax
               	jne	0x400cc1 <.text+0xa41>
               	movl	$0x13, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r12 # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %r15 # imm = 0x4000000000000000
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	callq	0x400506 <.text+0x286>
               	cmpq	$0x0, %rax
               	je	0x400d15 <.text+0xa95>
               	movl	$0x14, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movl	$0x2a, %r14d
               	movq	%r14, %rdi
               	callq	0x400524 <.text+0x2a4>
               	movabsq	$0x4045000000000000, %r14 # imm = 0x4045000000000000
               	movq	%rax, %xmm14
               	movq	%r14, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400d84 <.text+0xb04>
               	movl	$0x15, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$-0x3, %r15
               	movq	%r15, %rdi
               	callq	0x400524 <.text+0x2a4>
               	movabsq	$0x4008000000000000, %r15 # imm = 0x4008000000000000
               	movq	%r15, %xmm7
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
               	je	0x400e0b <.text+0xb8b>
               	movl	$0x16, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x400e000000000000, %r14 # imm = 0x400E000000000000
               	movq	%r14, %rdi
               	callq	0x400532 <.text+0x2b2>
               	cmpq	$0x3, %rax
               	je	0x400e52 <.text+0xbd2>
               	movl	$0x17, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x400e000000000000, %rax # imm = 0x400E000000000000
               	movq	%rax, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x150(%rbp)
               	movq	-0x150(%rbp), %r15
               	movq	%r15, %rdi
               	callq	0x400532 <.text+0x2b2>
               	cmpq	$-0x3, %rax
               	je	0x400ec5 <.text+0xc45>
               	movl	$0x18, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3fb999999999999a, %r14 # imm = 0x3FB999999999999A
               	movq	%r14, %rdi
               	callq	0x400540 <.text+0x2c0>
               	movq	%rax, %xmm14
               	movq	%r14, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400f2e <.text+0xcae>
               	movl	$0x19, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %r15 # imm = 0x4000000000000000
               	movq	%r15, %rdi
               	callq	0x400540 <.text+0x2c0>
               	movq	%rax, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400f97 <.text+0xd17>
               	movl	$0x1a, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
