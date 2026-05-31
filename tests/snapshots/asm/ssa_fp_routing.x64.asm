
ssa_fp_routing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40059b <.text+0x31b>
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
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40030b <.text+0x8b>
               	leaq	0xfe1a(%rip), %rdi      # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
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
               	leaq	0xfdf7(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfde5(%rip), %rsi      # 0x410116
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfdd4(%rip), %r9       # 0x41011d
               	movq	%r9, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x401167 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40039c <.text+0x11c>
               	leaq	0xfd74(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40039c <.text+0x11c>
               	leaq	0xfd55(%rip), %r12      # 0x4100f8
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%r12, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %rsi
               	movq	%rsi, %rcx
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
               	callq	0x4003d0 <.text+0x150>
               	movq	%rax, %r8
               	movabsq	$0x400e000000000000, %r12 # imm = 0x400E000000000000
               	movq	%r8, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	0x40063c <.text+0x3bc>
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
               	movabsq	$0x3ff8000000000000, %rbx # imm = 0x3FF8000000000000
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	0x4003eb <.text+0x16b>
               	movq	%rax, %r8
               	movabsq	$0x400c000000000000, %rbx # imm = 0x400C000000000000
               	movq	%r8, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x4006be <.text+0x43e>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x4004000000000000, %r12 # imm = 0x4004000000000000
               	movabsq	$0x4010000000000000, %r14 # imm = 0x4010000000000000
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	0x400406 <.text+0x186>
               	movq	%rax, %r8
               	movabsq	$0x4024000000000000, %r14 # imm = 0x4024000000000000
               	movq	%r8, %xmm14
               	movq	%r14, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400741 <.text+0x4c1>
               	movl	$0x3, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x402e000000000000, %rbx # imm = 0x402E000000000000
               	movabsq	$0x4010000000000000, %r12 # imm = 0x4010000000000000
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400421 <.text+0x1a1>
               	movq	%rax, %r8
               	movabsq	$0x400e000000000000, %r12 # imm = 0x400E000000000000
               	movq	%r8, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	0x4007c4 <.text+0x544>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x4004000000000000, %r14 # imm = 0x4004000000000000
               	movq	%r14, %rdi
               	callq	0x40043c <.text+0x1bc>
               	movq	%rax, %r12
               	movq	%r14, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%r12, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x400844 <.text+0x5c4>
               	movl	$0x5, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x401c000000000000, %rbx # imm = 0x401C000000000000
               	movq	%rbx, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x60(%rbp)
               	movq	-0x60(%rbp), %r14
               	movq	%r14, %rdi
               	callq	0x40043c <.text+0x1bc>
               	movq	%rax, %r8
               	movq	%r8, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x4008d6 <.text+0x656>
               	movl	$0x6, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r12 # imm = 0x3FF0000000000000
               	movq	%r12, %rdi
               	movq	%r12, %rsi
               	callq	0x40045e <.text+0x1de>
               	movq	%rax, %r8
               	cmpq	$0x0, %r8
               	jne	0x400923 <.text+0x6a3>
               	movl	$0x7, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r14 # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %r12 # imm = 0x4000000000000000
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	0x40045e <.text+0x1de>
               	movq	%rax, %rbx
               	cmpq	$0x0, %rbx
               	je	0x40097a <.text+0x6fa>
               	movl	$0x8, %r12d
               	movq	%r12, %rcx
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
               	callq	0x400487 <.text+0x207>
               	movq	%rax, %r14
               	cmpq	$0x0, %r14
               	jne	0x4009d1 <.text+0x751>
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
               	movabsq	$0x3ff0000000000000, %r12 # imm = 0x3FF0000000000000
               	movq	%r12, %rdi
               	movq	%r12, %rsi
               	callq	0x400487 <.text+0x207>
               	movq	%rax, %r14
               	cmpq	$0x0, %r14
               	je	0x400a1e <.text+0x79e>
               	movl	$0xa, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rbx # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %r14 # imm = 0x4000000000000000
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	0x4004b0 <.text+0x230>
               	movq	%rax, %r15
               	cmpq	$0x0, %r15
               	jne	0x400a75 <.text+0x7f5>
               	movl	$0xb, %r15d
               	movq	%r15, %rcx
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
               	callq	0x4004b0 <.text+0x230>
               	movq	%rax, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400acc <.text+0x84c>
               	movl	$0xc, %r14d
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
               	movabsq	$0x3ff0000000000000, %rbx # imm = 0x3FF0000000000000
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	callq	0x4004d9 <.text+0x259>
               	movq	%rax, %r12
               	cmpq	$0x0, %r12
               	jne	0x400b23 <.text+0x8a3>
               	movl	$0xd, %r12d
               	movq	%r12, %rcx
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
               	callq	0x4004d9 <.text+0x259>
               	movq	%rax, %r15
               	cmpq	$0x0, %r15
               	je	0x400b79 <.text+0x8f9>
               	movl	$0xe, %ebx
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
               	movq	%r12, %rdi
               	movq	%r12, %rsi
               	callq	0x4004f7 <.text+0x277>
               	movq	%rax, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400bc5 <.text+0x945>
               	movl	$0xf, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r15 # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %r12 # imm = 0x4000000000000000
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	callq	0x4004f7 <.text+0x277>
               	movq	%rax, %r14
               	cmpq	$0x0, %r14
               	jne	0x400c1c <.text+0x99c>
               	movl	$0x10, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movabsq	$0x3ff0000000000000, %r12 # imm = 0x3FF0000000000000
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x4004f7 <.text+0x277>
               	movq	%rax, %r15
               	cmpq	$0x0, %r15
               	je	0x400c73 <.text+0x9f3>
               	movl	$0x11, %r12d
               	movq	%r12, %rcx
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
               	callq	0x400520 <.text+0x2a0>
               	movq	%rax, %r12
               	cmpq	$0x0, %r12
               	jne	0x400cc0 <.text+0xa40>
               	movl	$0x12, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %r15 # imm = 0x4000000000000000
               	movabsq	$0x3ff0000000000000, %r14 # imm = 0x3FF0000000000000
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	callq	0x400520 <.text+0x2a0>
               	movq	%rax, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400d16 <.text+0xa96>
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
               	movabsq	$0x4000000000000000, %r14 # imm = 0x4000000000000000
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	0x400520 <.text+0x2a0>
               	movq	%rax, %r15
               	cmpq	$0x0, %r15
               	je	0x400d6d <.text+0xaed>
               	movl	$0x14, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movl	$0x2a, %ebx
               	movq	%rbx, %rdi
               	callq	0x40053e <.text+0x2be>
               	movq	%rax, %r14
               	movabsq	$0x4045000000000000, %rbx # imm = 0x4045000000000000
               	movq	%r14, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400ddd <.text+0xb5d>
               	movl	$0x15, %ebx
               	movq	%rbx, %rcx
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
               	callq	0x40053e <.text+0x2be>
               	movq	%rax, %rbx
               	movabsq	$0x4008000000000000, %r15 # imm = 0x4008000000000000
               	movq	%r15, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%rbx, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%r15b
               	movzbq	%r15b, %r15
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r15
               	cmpq	$0x0, %r15
               	je	0x400e66 <.text+0xbe6>
               	movl	$0x16, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x400e000000000000, %r12 # imm = 0x400E000000000000
               	movq	%r12, %rdi
               	callq	0x40054c <.text+0x2cc>
               	movq	%rax, %rbx
               	cmpq	$0x3, %rbx
               	je	0x400eaf <.text+0xc2f>
               	movl	$0x17, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x400e000000000000, %r12 # imm = 0x400E000000000000
               	movq	%r12, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x150(%rbp)
               	movq	-0x150(%rbp), %r15
               	movq	%r15, %rdi
               	callq	0x40054c <.text+0x2cc>
               	movq	%rax, %rbx
               	cmpq	$-0x3, %rbx
               	je	0x400f24 <.text+0xca4>
               	movl	$0x18, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	movabsq	$0x3fb999999999999a, %r12 # imm = 0x3FB999999999999A
               	movq	%r12, %rdi
               	callq	0x40055a <.text+0x2da>
               	movq	%rax, %rbx
               	movq	%rbx, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x400f8f <.text+0xd0f>
               	movl	$0x19, %ebx
               	movq	%rbx, %rcx
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
               	callq	0x40055a <.text+0x2da>
               	movq	%rax, %rbx
               	movq	%rbx, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400ffa <.text+0xd7a>
               	movl	$0x1a, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x180, %rsp            # imm = 0x180
               	popq	%rbp
               	retq
