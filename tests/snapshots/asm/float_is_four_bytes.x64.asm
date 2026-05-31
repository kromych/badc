
float_is_four_bytes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400580 <.text+0x280>
               	movq	%rax, %rdi
               	callq	*0xfde1(%rip)           # 0x4100f8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfdce(%rip), %r9       # 0x410108
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40038b <.text+0x8b>
               	leaq	0xfdaa(%rip), %rdi      # 0x410108
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
               	leaq	0xfd87(%rip), %rdi      # 0x410120
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfd75(%rip), %rsi      # 0x410126
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd64(%rip), %r9       # 0x41012d
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
               	callq	0x400fc7 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40041c <.text+0x11c>
               	leaq	0xfd04(%rip), %r14      # 0x410108
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40041c <.text+0x11c>
               	leaq	0xfce5(%rip), %r12      # 0x410108
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
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	0x10(%rbp), %r11
               	leaq	-0x8(%rbp), %r9
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r11
               	leaq	-0x8(%rbp), %r9
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movq	0x20(%rbp), %r9
               	leaq	-0x10(%rbp), %r11
               	movq	%r9, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r11,%riz)
               	movq	0x30(%rbp), %r11
               	leaq	-0x18(%rbp), %r9
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movapd	%xmm7, %xmm5
               	addsd	%xmm6, %xmm5
               	movss	-0x18(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movapd	%xmm5, %xmm0
               	addsd	%xmm6, %xmm0
               	movq	%xmm0, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	cmpq	$0x0, %r11
               	je	0x4005e1 <.text+0x2e1>
               	leaq	0xfbaf(%rip), %rbx      # 0x410168
               	movl	$0x4, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movl	%r8d, -0x8(%rbp)
               	jmp	0x4005e1 <.text+0x2e1>
               	xorq	%r8, %r8
               	cmpq	$0x0, %r8
               	je	0x40061e <.text+0x31e>
               	leaq	0xfb88(%rip), %r14      # 0x410180
               	movl	$0x8, %r12d
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x2, %ebx
               	movl	%ebx, -0x8(%rbp)
               	jmp	0x40061e <.text+0x31e>
               	xorq	%rbx, %rbx
               	leaq	-0x10(%rbp), %r12
               	movq	%rbx, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r12)
               	cmpq	$0x0, %rbx
               	je	0x400675 <.text+0x375>
               	leaq	0xfb4c(%rip), %r15      # 0x410199
               	movl	$0x4, %r12d
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x3, %r14d
               	movl	%r14d, -0x8(%rbp)
               	jmp	0x400675 <.text+0x375>
               	leaq	-0x18(%rbp), %r14
               	movabsq	$0x3ff8000000000000, %r12 # imm = 0x3FF8000000000000
               	movq	%r12, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r14,%riz)
               	leaq	-0x18(%rbp), %r12
               	movq	%r12, %r14
               	addq	$0x4, %r14
               	movl	$0x12345678, %r12d      # imm = 0x12345678
               	movl	%r12d, (%r14)
               	leaq	-0x18(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %r14
               	cmpq	$0x12345678, %r14       # imm = 0x12345678
               	je	0x400703 <.text+0x403>
               	leaq	0xfada(%rip), %rbx      # 0x4101ae
               	movl	$0x4, %r14d
               	movq	%r15, %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movl	%r14d, -0x8(%rbp)
               	jmp	0x400703 <.text+0x403>
               	leaq	-0x18(%rbp), %r14
               	movss	(%r14,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x3ff8000000000000, %r14 # imm = 0x3FF8000000000000
               	movq	%r14, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%dil
               	movzbq	%dil, %rdi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x40076d <.text+0x46d>
               	leaq	0xfa83(%rip), %r15      # 0x4101d3
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movl	$0x5, %edi
               	movl	%edi, -0x8(%rbp)
               	jmp	0x40076d <.text+0x46d>
               	leaq	0xf9e4(%rip), %rdi      # 0x410158
               	movq	%rdi, %r15
               	addq	$0x4, %r15
               	movq	%r15, %r12
               	subq	%rdi, %r12
               	cmpq	$0x4, %r12
               	je	0x4007cf <.text+0x4cf>
               	leaq	0xfa55(%rip), %r14      # 0x4101ed
               	leaq	0xf9b9(%rip), %r15      # 0x410158
               	movq	%r15, %rbx
               	addq	$0x4, %rbx
               	movq	%rbx, %r12
               	subq	%rdi, %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x6, %ebx
               	movl	%ebx, -0x8(%rbp)
               	jmp	0x4007cf <.text+0x4cf>
               	leaq	0xf982(%rip), %rbx      # 0x410158
               	movss	(%rbx,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x3ff8000000000000, %rbx # imm = 0x3FF8000000000000
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400866 <.text+0x566>
               	leaq	0xf9e6(%rip), %r15      # 0x410204
               	leaq	0xf933(%rip), %r12      # 0x410158
               	movss	(%r12), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	movsd	0x48(%rsp), %xmm0
               	movq	%r15, %rdi
               	movb	$0x1, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movl	$0x7, %r12d
               	movl	%r12d, -0x8(%rbp)
               	jmp	0x400866 <.text+0x566>
               	leaq	0xf8eb(%rip), %r12      # 0x410158
               	movq	%r12, %r15
               	addq	$0x4, %r15
               	movss	(%r15,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x4004000000000000, %r15 # imm = 0x4004000000000000
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400912 <.text+0x612>
               	leaq	0xf958(%rip), %rbx      # 0x410218
               	leaq	0xf891(%rip), %r12      # 0x410158
               	movq	%r12, %r14
               	addq	$0x4, %r14
               	movss	(%r14,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x40(%rsp)
               	movsd	0x40(%rsp), %xmm0
               	movq	%rbx, %rdi
               	movb	$0x1, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x8, %r14d
               	movl	%r14d, -0x8(%rbp)
               	jmp	0x400912 <.text+0x612>
               	leaq	0xf83f(%rip), %r14      # 0x410158
               	movq	%r14, %rbx
               	addq	$0x8, %rbx
               	movss	(%rbx,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x400c000000000000, %rbx # imm = 0x400C000000000000
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%r14b
               	movzbq	%r14b, %r14
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x4009bd <.text+0x6bd>
               	leaq	0xf8c1(%rip), %r15      # 0x41022c
               	leaq	0xf7e6(%rip), %r14      # 0x410158
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movss	(%r12), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	movsd	0x38(%rsp), %xmm0
               	movq	%r15, %rdi
               	movb	$0x1, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movl	$0x9, %r12d
               	movl	%r12d, -0x8(%rbp)
               	jmp	0x4009bd <.text+0x6bd>
               	leaq	0xf794(%rip), %r12      # 0x410158
               	movq	%r12, %r15
               	addq	$0xc, %r15
               	movss	(%r15,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x4012000000000000, %r15 # imm = 0x4012000000000000
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400a69 <.text+0x769>
               	leaq	0xf829(%rip), %rbx      # 0x410240
               	leaq	0xf73a(%rip), %r12      # 0x410158
               	movq	%r12, %r14
               	addq	$0xc, %r14
               	movss	(%r14,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x30(%rsp)
               	movsd	0x30(%rsp), %xmm0
               	movq	%rbx, %rdi
               	movb	$0x1, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0xa, %r14d
               	movl	%r14d, -0x8(%rbp)
               	jmp	0x400a69 <.text+0x769>
               	movabsq	$0x3ff8000000000000, %r15 # imm = 0x3FF8000000000000
               	movq	%r15, %rdi
               	callq	0x400450 <.text+0x150>
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
               	je	0x400ad3 <.text+0x7d3>
               	leaq	0xf7a0(%rip), %r14      # 0x410254
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movl	$0xb, %r12d
               	movl	%r12d, -0x8(%rbp)
               	jmp	0x400ad3 <.text+0x7d3>
               	movabsq	$0x4004000000000000, %rbx # imm = 0x4004000000000000
               	movq	%rbx, %rdi
               	callq	0x400450 <.text+0x150>
               	movq	%rax, %r14
               	movq	%r14, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r15b
               	movzbq	%r15b, %r15
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r15
               	cmpq	$0x0, %r15
               	je	0x400b3d <.text+0x83d>
               	leaq	0xf74d(%rip), %r12      # 0x41026b
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0xc, %r15d
               	movl	%r15d, -0x8(%rbp)
               	jmp	0x400b3d <.text+0x83d>
               	movabsq	$0x3ff8000000000000, %r14 # imm = 0x3FF8000000000000
               	movq	%r14, %rdi
               	callq	0x400450 <.text+0x150>
               	movq	%rax, %r15
               	movabsq	$0x4004000000000000, %r12 # imm = 0x4004000000000000
               	movq	%r12, %rdi
               	callq	0x400450 <.text+0x150>
               	movq	%rax, %rbx
               	movq	%r15, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%r12b
               	movzbq	%r12b, %r12
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400bbc <.text+0x8bc>
               	leaq	0xf6e5(%rip), %r14      # 0x410282
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movl	$0xd, %r12d
               	movl	%r12d, -0x8(%rbp)
               	jmp	0x400bbc <.text+0x8bc>
               	movabsq	$0x3ff0000000000000, %rbx # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %r12 # imm = 0x4000000000000000
               	movabsq	$0x400c000000000000, %r14 # imm = 0x400C000000000000
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	0x4004ac <.text+0x1ac>
               	movq	%rax, %rdi
               	movabsq	$0x401a000000000000, %r14 # imm = 0x401A000000000000
               	movq	%rdi, %xmm14
               	movq	%r14, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400cad <.text+0x9ad>
               	leaq	0xf681(%rip), %r10      # 0x4102ac
               	movq	%r10, 0x28(%rsp)
               	movabsq	$0x3ff0000000000000, %r12 # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movabsq	$0x400c000000000000, %rbx # imm = 0x400C000000000000
               	movq	%r12, -0xa8(%rbp)
               	movq	-0xa8(%rbp), %r14
               	movq	%rdi, -0xb0(%rbp)
               	movq	-0xb0(%rbp), %r12
               	movq	%rbx, -0xb8(%rbp)
               	movq	-0xb8(%rbp), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	0x4004ac <.text+0x1ac>
               	movq	%rax, %r15
               	movq	%r15, %xmm0
               	movq	0x28(%rsp), %rdi
               	movb	$0x1, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0xe, %ebx
               	movl	%ebx, -0x8(%rbp)
               	jmp	0x400cad <.text+0x9ad>
               	movabsq	$0x3ff8000000000000, %rbx # imm = 0x3FF8000000000000
               	leaq	-0x30(%rbp), %r15
               	movq	%rbx, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r15,%riz)
               	movabsq	$0x4000000000000000, %r15 # imm = 0x4000000000000000
               	leaq	-0x38(%rbp), %rbx
               	movq	%r15, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rbx,%riz)
               	movss	-0x30(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movss	-0x38(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movapd	%xmm7, %xmm5
               	mulsd	%xmm6, %xmm5
               	movabsq	$0x3fd0000000000000, %rbx # imm = 0x3FD0000000000000
               	movapd	%xmm5, %xmm6
               	movq	%rbx, %xmm15
               	addsd	%xmm15, %xmm6
               	leaq	-0x40(%rbp), %rbx
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%rbx,%riz)
               	movss	-0x40(%rbp,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	movabsq	$0x400a000000000000, %rbx # imm = 0x400A000000000000
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm5
               	setne	%r15b
               	movzbq	%r15b, %r15
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r15
               	cmpq	$0x0, %r15
               	je	0x400dc7 <.text+0xac7>
               	leaq	0xf536(%rip), %r14      # 0x4102bc
               	movss	-0x40(%rbp,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x20(%rsp)
               	movsd	0x20(%rsp), %xmm0
               	movq	%r14, %rdi
               	movb	$0x1, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0xf, %r15d
               	movl	%r15d, -0x8(%rbp)
               	jmp	0x400dc7 <.text+0xac7>
               	movabsq	$0x3ff0000000000000, %r15 # imm = 0x3FF0000000000000
               	leaq	-0x48(%rbp), %r14
               	movq	%r15, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r14,%riz)
               	leaq	-0x50(%rbp), %rbx
               	leaq	-0x48(%rbp), %r14
               	movl	$0x4, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400fd3 <memcpy>
               	movq	%rax, %r12
               	movl	-0x50(%rbp), %r12d
               	movq	%r12, %r15
               	xorq	$0x3f800000, %r15       # imm = 0x3F800000
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	cmpq	$0x0, %r12
               	je	0x400e5b <.text+0xb5b>
               	leaq	0xf49c(%rip), %rbx      # 0x4102d1
               	movl	-0x50(%rbp), %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400fcd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x10, %r14d
               	movl	%r14d, -0x8(%rbp)
               	jmp	0x400e5b <.text+0xb5b>
               	movslq	-0x8(%rbp), %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	orb	(%r9), %cl
               	jbe	0x400ebb <.text+0xbbb>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x400f42 <.text+0xc42>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400f39 <.text+0xc39>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400f3d <.text+0xc3d>
               	andb	%ch, 0x74(%rax)
               	je	0x400f4d <.text+0xc4d>
               	jae	0x400f19 <.text+0xc19>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400f55 <.text+0xc55>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%dl, 0x48(%rbp)
               	movl	%esp, %ebp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400fd9 <exit>
               	movzbq	%al, %rax
               	movq	%rax, %r9
               	xorq	%r9, %r9
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x400f7b <.text+0xc7b>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x401002 <exit+0x29>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400ff9 <exit+0x20>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400ffd <exit+0x24>
               	andb	%ch, 0x74(%rax)
               	je	0x40100d <exit+0x34>
               	jae	0x400fd9 <exit>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x401015 <exit+0x3c>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf113(%rip)           # 0x4100e0

<printf>:
               	jmpq	*0xf115(%rip)           # 0x4100e8

<memcpy>:
               	jmpq	*0xf117(%rip)           # 0x4100f0

<exit>:
               	jmpq	*0xf119(%rip)           # 0x4100f8
