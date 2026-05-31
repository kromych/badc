
float_is_four_bytes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40057d <.text+0x27d>
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
               	callq	0x400f67 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400419 <.text+0x119>
               	leaq	0xfd07(%rip), %r14      # 0x410108
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400419 <.text+0x119>
               	leaq	0xfce8(%rip), %r12      # 0x410108
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %rcx
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
               	je	0x4005d9 <.text+0x2d9>
               	leaq	0xfbb2(%rip), %rbx      # 0x410168
               	movl	$0x4, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x4005d9 <.text+0x2d9>
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400613 <.text+0x313>
               	leaq	0xfb90(%rip), %r14      # 0x410180
               	movl	$0x8, %r12d
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400613 <.text+0x313>
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %r12
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r12)
               	cmpq	$0x0, %rax
               	je	0x400665 <.text+0x365>
               	leaq	0xfb57(%rip), %rbx      # 0x410199
               	movl	$0x4, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400665 <.text+0x365>
               	leaq	-0x18(%rbp), %rax
               	movabsq	$0x3ff8000000000000, %r12 # imm = 0x3FF8000000000000
               	movq	%r12, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	leaq	-0x18(%rbp), %r12
               	movq	%r12, %rax
               	addq	$0x4, %rax
               	movl	$0x12345678, %r12d      # imm = 0x12345678
               	movl	%r12d, (%rax)
               	leaq	-0x18(%rbp), %rbx
               	movq	%rbx, %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %rax
               	cmpq	$0x12345678, %rax       # imm = 0x12345678
               	je	0x4006f0 <.text+0x3f0>
               	leaq	0xfaea(%rip), %r14      # 0x4101ae
               	movl	$0x4, %r15d
               	movq	%rbx, %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	%r15d, -0x8(%rbp)
               	jmp	0x4006f0 <.text+0x3f0>
               	leaq	-0x18(%rbp), %r15
               	movss	(%r15,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x3ff8000000000000, %r15 # imm = 0x3FF8000000000000
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400757 <.text+0x457>
               	leaq	0xfa96(%rip), %rbx      # 0x4101d3
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400757 <.text+0x457>
               	leaq	0xf9fa(%rip), %rax      # 0x410158
               	movq	%rax, %rbx
               	addq	$0x4, %rbx
               	movq	%rbx, %r12
               	subq	%rax, %r12
               	cmpq	$0x4, %r12
               	je	0x4007b6 <.text+0x4b6>
               	leaq	0xfa6b(%rip), %r15      # 0x4101ed
               	leaq	0xf9cf(%rip), %rbx      # 0x410158
               	movq	%rbx, %r14
               	addq	$0x4, %r14
               	movq	%r14, %r12
               	subq	%rax, %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x4007b6 <.text+0x4b6>
               	leaq	0xf99b(%rip), %rax      # 0x410158
               	movss	(%rax,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400848 <.text+0x548>
               	leaq	0xf9ff(%rip), %rbx      # 0x410204
               	leaq	0xf94c(%rip), %r12      # 0x410158
               	movss	(%r12), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	movsd	0x48(%rsp), %xmm0
               	movq	%rbx, %rdi
               	movb	$0x1, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400848 <.text+0x548>
               	leaq	0xf909(%rip), %rax      # 0x410158
               	movq	%rax, %rbx
               	addq	$0x4, %rbx
               	movss	(%rbx,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x4004000000000000, %rbx # imm = 0x4004000000000000
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4008ee <.text+0x5ee>
               	leaq	0xf977(%rip), %r12      # 0x410218
               	leaq	0xf8b0(%rip), %rax      # 0x410158
               	movq	%rax, %r15
               	addq	$0x4, %r15
               	movss	(%r15,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x40(%rsp)
               	movsd	0x40(%rsp), %xmm0
               	movq	%r12, %rdi
               	movb	$0x1, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	$0x8, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x4008ee <.text+0x5ee>
               	leaq	0xf863(%rip), %rax      # 0x410158
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movss	(%r12), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x400c000000000000, %r12 # imm = 0x400C000000000000
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400995 <.text+0x695>
               	leaq	0xf8e4(%rip), %rbx      # 0x41022c
               	leaq	0xf809(%rip), %rax      # 0x410158
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movss	(%r15,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	movsd	0x38(%rsp), %xmm0
               	movq	%rbx, %rdi
               	movb	$0x1, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	$0x9, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400995 <.text+0x695>
               	leaq	0xf7bc(%rip), %rax      # 0x410158
               	movq	%rax, %rbx
               	addq	$0xc, %rbx
               	movss	(%rbx,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x4012000000000000, %rbx # imm = 0x4012000000000000
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400a3b <.text+0x73b>
               	leaq	0xf852(%rip), %r12      # 0x410240
               	leaq	0xf763(%rip), %rax      # 0x410158
               	movq	%rax, %r15
               	addq	$0xc, %r15
               	movss	(%r15,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x30(%rsp)
               	movsd	0x30(%rsp), %xmm0
               	movq	%r12, %rdi
               	movb	$0x1, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	$0xa, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400a3b <.text+0x73b>
               	movabsq	$0x3ff8000000000000, %rbx # imm = 0x3FF8000000000000
               	movq	%rbx, %rdi
               	callq	0x40044d <.text+0x14d>
               	movq	%rax, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r15b
               	movzbq	%r15b, %r15
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r15
               	cmpq	$0x0, %r15
               	je	0x400a9d <.text+0x79d>
               	leaq	0xf7d1(%rip), %r12      # 0x410254
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	$0xb, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400a9d <.text+0x79d>
               	movabsq	$0x4004000000000000, %r15 # imm = 0x4004000000000000
               	movq	%r15, %rdi
               	callq	0x40044d <.text+0x14d>
               	movq	%rax, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400aff <.text+0x7ff>
               	leaq	0xf786(%rip), %r12      # 0x41026b
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	$0xc, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400aff <.text+0x7ff>
               	movabsq	$0x3ff8000000000000, %rbx # imm = 0x3FF8000000000000
               	movq	%rbx, %rdi
               	callq	0x40044d <.text+0x14d>
               	movq	%rax, %r14
               	movabsq	$0x4004000000000000, %r12 # imm = 0x4004000000000000
               	movq	%r12, %rdi
               	callq	0x40044d <.text+0x14d>
               	movq	%r14, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%r12b
               	movzbq	%r12b, %r12
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400b76 <.text+0x876>
               	leaq	0xf726(%rip), %r15      # 0x410282
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	$0xd, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400b76 <.text+0x876>
               	movabsq	$0x3ff0000000000000, %r12 # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movabsq	$0x400c000000000000, %r15 # imm = 0x400C000000000000
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	callq	0x4004a9 <.text+0x1a9>
               	movabsq	$0x401a000000000000, %r15 # imm = 0x401A000000000000
               	movq	%rax, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400c61 <.text+0x961>
               	leaq	0xf6ca(%rip), %r10      # 0x4102ac
               	movq	%r10, 0x28(%rsp)
               	movabsq	$0x3ff0000000000000, %rbx # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movabsq	$0x400c000000000000, %r12 # imm = 0x400C000000000000
               	movq	%rbx, -0xa8(%rbp)
               	movq	-0xa8(%rbp), %r15
               	movq	%rax, -0xb0(%rbp)
               	movq	-0xb0(%rbp), %rbx
               	movq	%r12, -0xb8(%rbp)
               	movq	-0xb8(%rbp), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	callq	0x4004a9 <.text+0x1a9>
               	movq	%rax, %r14
               	movq	%r14, %xmm0
               	movq	0x28(%rsp), %rdi
               	movb	$0x1, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	$0xe, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400c61 <.text+0x961>
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	leaq	-0x30(%rbp), %r14
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r14,%riz)
               	movabsq	$0x4000000000000000, %r14 # imm = 0x4000000000000000
               	leaq	-0x38(%rbp), %rax
               	movq	%r14, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	movss	-0x30(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movss	-0x38(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movapd	%xmm7, %xmm5
               	mulsd	%xmm6, %xmm5
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movapd	%xmm5, %xmm6
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm6
               	leaq	-0x40(%rbp), %rax
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	movss	-0x40(%rbp,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	movabsq	$0x400a000000000000, %rax # imm = 0x400A000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm5
               	setne	%r14b
               	movzbq	%r14b, %r14
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x400d76 <.text+0xa76>
               	leaq	0xf582(%rip), %r12      # 0x4102bc
               	movss	-0x40(%rbp,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x20(%rsp)
               	movsd	0x20(%rsp), %xmm0
               	movq	%r12, %rdi
               	movb	$0x1, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	$0xf, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400d76 <.text+0xa76>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	leaq	-0x48(%rbp), %r12
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r12)
               	leaq	-0x50(%rbp), %r14
               	leaq	-0x48(%rbp), %r12
               	movl	$0x4, %r15d
               	movq	%r14, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x400f73 <memcpy>
               	movl	-0x50(%rbp), %eax
               	movq	%rax, %r15
               	xorq	$0x3f800000, %r15       # imm = 0x3F800000
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r15, %rax
               	cmpq	$0x0, %rax
               	je	0x400e00 <.text+0xb00>
               	leaq	0xf4f2(%rip), %rbx      # 0x4102d1
               	movl	-0x50(%rbp), %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400f6d <printf>
               	movslq	%eax, %rax
               	movl	$0x10, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400e00 <.text+0xb00>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
