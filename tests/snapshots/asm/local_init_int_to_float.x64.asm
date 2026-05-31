
local_init_int_to_float.x64:	file format elf64-x86-64

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
               	callq	0x400af7 <dlsym>
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
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	-0x8(%rbp), %r11
               	leaq	0xfd1c(%rip), %r9       # 0x410150
               	pushq	%rax
               	movzbq	(%r9), %rax
               	movb	%al, (%r11)
               	movzbq	0x1(%r9), %rax
               	movb	%al, 0x1(%r11)
               	movzbq	0x2(%r9), %rax
               	movb	%al, 0x2(%r11)
               	movzbq	0x3(%r9), %rax
               	movb	%al, 0x3(%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x8(%rbp), %r8
               	movzbq	(%r8), %r9
               	cvtsi2sd	%r9, %xmm7
               	leaq	-0x10(%rbp), %r9
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x4044f33333333333, %r9 # imm = 0x4044F33333333333
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm6
               	setb	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	movq	%r8, -0x78(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x4004f2 <.text+0x232>
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x40450ccccccccccd, %r8 # imm = 0x40450CCCCCCCCCCD
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm6
               	seta	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x78(%rbp)
               	jmp	0x4004f2 <.text+0x232>
               	movq	-0x78(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x40055f <.text+0x29f>
               	leaq	0xfc4a(%rip), %rbx      # 0x410154
               	movss	-0x10(%rbp,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	movsd	0x38(%rsp), %xmm0
               	movq	%rbx, %rdi
               	movb	$0x1, %al
               	callq	0x400afd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3039, %ebx           # imm = 0x3039
               	movslq	%ebx, %r9
               	cvtsi2sd	%r9, %xmm6
               	leaq	-0x20(%rbp), %r9
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x20(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x40c81c4000000000, %r9 # imm = 0x40C81C4000000000
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setb	%bl
               	movzbq	%bl, %rbx
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rbx
               	movq	%rbx, -0x80(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x4005f6 <.text+0x336>
               	movss	-0x20(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x40c81cc000000000, %rbx # imm = 0x40C81CC000000000
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm7
               	seta	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x80(%rbp)
               	jmp	0x4005f6 <.text+0x336>
               	movq	-0x80(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x400663 <.text+0x3a3>
               	leaq	0xfb5c(%rip), %r12      # 0x41016a
               	movss	-0x20(%rbp,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x30(%rsp)
               	movsd	0x30(%rsp), %xmm0
               	movq	%r12, %rdi
               	movb	$0x1, %al
               	callq	0x400afd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	movl	$0x2, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x7, %r12
               	movslq	%r12d, %r9
               	cvtsi2sd	%r9, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x30(%rbp)
               	movq	-0x30(%rbp), %r9
               	movabsq	$0x401e000000000000, %r12 # imm = 0x401E000000000000
               	movq	%r12, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%r9, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%r12b
               	movzbq	%r12b, %r12
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r12
               	movq	%r12, -0x88(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x40071b <.text+0x45b>
               	movq	-0x30(%rbp), %r9
               	movabsq	$0x401a000000000000, %r12 # imm = 0x401A000000000000
               	movq	%r12, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%r9, %xmm14
               	ucomisd	%xmm7, %xmm14
               	seta	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x88(%rbp)
               	jmp	0x40071b <.text+0x45b>
               	movq	-0x88(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x400772 <.text+0x4b2>
               	leaq	0xfa4c(%rip), %rbx      # 0x410182
               	movq	-0x30(%rbp), %r14
               	movq	%r14, %xmm0
               	movq	%rbx, %rdi
               	movb	$0x1, %al
               	callq	0x400afd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r11
               	movl	$0x3, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r14, %r11
               	cvtsi2sd	%r11, %xmm7
               	leaq	-0x40(%rbp), %r11
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r11,%riz)
               	movss	-0x40(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x41eff68690000000, %r11 # imm = 0x41EFF68690000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm6
               	setb	%r14b
               	movzbq	%r14b, %r14
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r14
               	movq	%r14, -0x90(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x400816 <.text+0x556>
               	movss	-0x40(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x41f004ccb0000000, %r14 # imm = 0x41F004CCB0000000
               	movq	%r14, %xmm15
               	ucomisd	%xmm15, %xmm6
               	seta	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x90(%rbp)
               	jmp	0x400816 <.text+0x556>
               	movq	-0x90(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400886 <.text+0x5c6>
               	leaq	0xf96a(%rip), %r12      # 0x41019b
               	movss	-0x40(%rbp,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	movsd	0x28(%rsp), %xmm0
               	movq	%r12, %rdi
               	movb	$0x1, %al
               	callq	0x400afd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r11
               	movl	$0x4, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x400d99999999999a, %r12 # imm = 0x400D99999999999A
               	leaq	-0x48(%rbp), %r11
               	movq	%r12, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r11,%riz)
               	movss	-0x48(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	cvttsd2si	%xmm6, %r11
               	movslq	%r11d, %r12
               	cmpq	$0x3, %r12
               	je	0x40090a <.text+0x64a>
               	leaq	0xf8e2(%rip), %r14      # 0x4101b3
               	movslq	%r11d, %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400afd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r11
               	movl	$0x5, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4007333333333333, %r12 # imm = 0x4007333333333333
               	movq	%r12, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	movq	%xmm6, %r11
               	movq	%r11, -0x58(%rbp)
               	movq	-0x58(%rbp), %r12
               	movq	%r12, %xmm14
               	cvttsd2si	%xmm14, %r11
               	movslq	%r11d, %r12
               	cmpq	$-0x2, %r12
               	je	0x400994 <.text+0x6d4>
               	leaq	0xf86f(%rip), %rbx      # 0x4101ca
               	movslq	%r11d, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400afd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r11
               	movl	$0x6, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x4009ef <.text+0x72f>
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
               	jae	0x400a76 <.text+0x7b6>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400a6d <.text+0x7ad>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400a71 <.text+0x7b1>
               	andb	%ch, 0x74(%rax)
               	je	0x400a81 <.text+0x7c1>
               	jae	0x400a4d <.text+0x78d>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400a89 <.text+0x7c9>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%dl, 0x48(%rbp)
               	movl	%esp, %ebp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400b03 <exit>
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
               	jbe	0x400aab <.text+0x7eb>
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
               	jae	0x400b32 <exit+0x2f>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400b29 <exit+0x26>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400b2d <exit+0x2a>
               	andb	%ch, 0x74(%rax)
               	je	0x400b3d <exit+0x3a>
               	jae	0x400b09 <exit+0x6>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400b45 <exit+0x42>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf5e3(%rip)           # 0x4100e0

<printf>:
               	jmpq	*0xf5e5(%rip)           # 0x4100e8

<exit>:
               	jmpq	*0xf5e7(%rip)           # 0x4100f0
