
int_to_float_assign_conversion.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400410 <.text+0x150>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100f0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe06(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40034b <.text+0x8b>
               	leaq	0xfde2(%rip), %rdi      # 0x410100
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
               	leaq	0xfdbf(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfdad(%rip), %rsi      # 0x41011e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd9c(%rip), %r9       # 0x410125
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
               	callq	0x400967 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x4003dc <.text+0x11c>
               	leaq	0xfd3c(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4003dc <.text+0x11c>
               	leaq	0xfd1d(%rip), %r12      # 0x410100
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x8(%rbp), %r11
               	movl	$0xa, %r9d
               	movb	%r9b, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movl	$0x64, %r8d
               	movb	%r8b, (%r11)
               	leaq	-0x8(%rbp), %rdi
               	movq	%rdi, %r8
               	addq	$0x2, %r8
               	movl	$0xc8, %edi
               	movb	%dil, (%r8)
               	leaq	-0x8(%rbp), %r11
               	movzbq	(%r11), %rdi
               	cvtsi2sd	%rdi, %xmm7
               	leaq	-0x10(%rbp), %rdi
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%rdi,%riz)
               	leaq	-0x8(%rbp), %rdi
               	movq	%rdi, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %rdi
               	cvtsi2sd	%rdi, %xmm6
               	leaq	-0x18(%rbp), %rdi
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%rdi,%riz)
               	leaq	-0x8(%rbp), %rdi
               	movq	%rdi, %r11
               	addq	$0x2, %r11
               	movzbq	(%r11), %rdi
               	cvtsi2sd	%rdi, %xmm7
               	leaq	-0x20(%rbp), %rdi
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%rdi,%riz)
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	cvtsi2sd	%r9, %xmm7
               	movapd	%xmm6, %xmm5
               	mulsd	%xmm7, %xmm5
               	cvttsd2si	%xmm5, %r9
               	cmpq	$0x64, %r9
               	je	0x400512 <.text+0x252>
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movss	-0x18(%rbp,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	movl	$0xa, %r9d
               	cvtsi2sd	%r9, %xmm7
               	movapd	%xmm5, %xmm6
               	mulsd	%xmm7, %xmm6
               	cvttsd2si	%xmm6, %r9
               	cmpq	$0x3e8, %r9             # imm = 0x3E8
               	je	0x40055d <.text+0x29d>
               	movl	$0x2, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movss	-0x20(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movl	$0xa, %r9d
               	cvtsi2sd	%r9, %xmm7
               	movapd	%xmm6, %xmm5
               	mulsd	%xmm7, %xmm5
               	cvttsd2si	%xmm5, %r9
               	cmpq	$0x7d0, %r9             # imm = 0x7D0
               	je	0x4005a8 <.text+0x2e8>
               	movl	$0x3, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rdi
               	leaq	-0x8(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %r9
               	cvtsi2sd	%r9, %xmm5
               	cvtsd2ss	%xmm5, %xmm15
               	movss	%xmm15, (%rdi,%riz)
               	movss	-0x28(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movl	$0x64, %edi
               	cvtsi2sd	%rdi, %xmm5
               	movapd	%xmm7, %xmm6
               	mulsd	%xmm5, %xmm6
               	cvttsd2si	%xmm6, %rdi
               	cmpq	$0x2710, %rdi           # imm = 0x2710
               	je	0x40061b <.text+0x35b>
               	movl	$0x4, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3fd322d0e5604189, %r9 # imm = 0x3FD322D0E5604189
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movq	%r9, %xmm5
               	mulsd	%xmm6, %xmm5
               	movabsq	$0x3fe2c8b439581062, %r9 # imm = 0x3FE2C8B439581062
               	movss	-0x18(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movq	%r9, %xmm7
               	mulsd	%xmm6, %xmm7
               	movapd	%xmm5, %xmm6
               	addsd	%xmm7, %xmm6
               	movabsq	$0x3fbd2f1a9fbe76c9, %r9 # imm = 0x3FBD2F1A9FBE76C9
               	movss	-0x20(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movq	%r9, %xmm5
               	mulsd	%xmm7, %xmm5
               	movapd	%xmm6, %xmm7
               	addsd	%xmm5, %xmm7
               	movabsq	$0x4060000000000000, %r9 # imm = 0x4060000000000000
               	movapd	%xmm7, %xmm5
               	movq	%r9, %xmm15
               	subsd	%xmm15, %xmm5
               	leaq	-0x30(%rbp), %r9
               	cvtsd2ss	%xmm5, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x30(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x4045800000000000, %r9 # imm = 0x4045800000000000
               	movq	%r9, %xmm5
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm5
               	ucomisd	%xmm5, %xmm7
               	seta	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x50(%rbp)
               	cmpq	$0x0, %r9
               	jne	0x400753 <.text+0x493>
               	movss	-0x30(%rbp,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	movabsq	$0x4046000000000000, %r9 # imm = 0x4046000000000000
               	movq	%r9, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	ucomisd	%xmm7, %xmm5
               	setb	%r9b
               	movzbq	%r9b, %r9
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r9
               	movq	%r9, -0x50(%rbp)
               	jmp	0x400753 <.text+0x493>
               	movq	-0x50(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x40077c <.text+0x4bc>
               	movl	$0x5, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %r9d
               	movslq	%r9d, %rdi
               	cvtsi2sd	%rdi, %xmm7
               	leaq	-0x40(%rbp), %rdi
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%rdi,%riz)
               	movss	-0x40(%rbp,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	movabsq	$0x401c000000000000, %rdi # imm = 0x401C000000000000
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm5
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x4007f6 <.text+0x536>
               	movl	$0x6, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf953(%rip), %rbx      # 0x410150
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x40096d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x40085b <.text+0x59b>
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
               	jae	0x4008e2 <.text+0x622>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4008d9 <.text+0x619>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4008dd <.text+0x61d>
               	andb	%ch, 0x74(%rax)
               	je	0x4008ed <.text+0x62d>
               	jae	0x4008b9 <.text+0x5f9>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4008f5 <.text+0x635>
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
               	callq	0x400973 <exit>
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
               	jbe	0x40091b <.text+0x65b>
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
               	jae	0x4009a2 <exit+0x2f>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400999 <exit+0x26>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40099d <exit+0x2a>
               	andb	%ch, 0x74(%rax)
               	je	0x4009ad <exit+0x3a>
               	jae	0x400979 <exit+0x6>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4009b5 <exit+0x42>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf773(%rip)           # 0x4100e0

<printf>:
               	jmpq	*0xf775(%rip)           # 0x4100e8

<exit>:
               	jmpq	*0xf777(%rip)           # 0x4100f0
