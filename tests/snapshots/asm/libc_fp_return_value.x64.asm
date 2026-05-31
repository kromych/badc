
libc_fp_return_value.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400510 <.text+0x150>
               	movq	%rax, %rdi
               	callq	*0xfd49(%rip)           # 0x410120
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfd36(%rip), %r9       # 0x410130
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40044b <.text+0x8b>
               	leaq	0xfd12(%rip), %rdi      # 0x410130
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
               	leaq	0xfcef(%rip), %rdi      # 0x410148
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfcdd(%rip), %rsi      # 0x41014e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfccc(%rip), %r9       # 0x410155
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
               	callq	0x4008c7 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x4004dc <.text+0x11c>
               	leaq	0xfc6c(%rip), %r14      # 0x410130
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4004dc <.text+0x11c>
               	leaq	0xfc4d(%rip), %r12      # 0x410130
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
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0x1, %r11d
               	movl	%r11d, -0x8(%rbp)
               	movabsq	$0x4010000000000000, %rbx # imm = 0x4010000000000000
               	movq	%rbx, %xmm0
               	xorl	%eax, %eax
               	callq	0x4008cd <sqrt>
               	movq	%xmm0, %r11
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movq	%r11, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x400592 <.text+0x1d2>
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x8(%rbp)
               	jmp	0x400592 <.text+0x1d2>
               	movabsq	$0x400599999999999a, %r12 # imm = 0x400599999999999A
               	movq	%r12, %xmm0
               	xorl	%eax, %eax
               	callq	0x4008d3 <floor>
               	movq	%xmm0, %r8
               	movabsq	$0x4000000000000000, %r12 # imm = 0x4000000000000000
               	movq	%r8, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x4005f2 <.text+0x232>
               	xorq	%r12, %r12
               	movl	%r12d, -0x8(%rbp)
               	jmp	0x4005f2 <.text+0x232>
               	movabsq	$0x4002666666666666, %rbx # imm = 0x4002666666666666
               	movq	%rbx, %xmm0
               	xorl	%eax, %eax
               	callq	0x4008d9 <ceil>
               	movq	%xmm0, %r11
               	movabsq	$0x4008000000000000, %rbx # imm = 0x4008000000000000
               	movq	%r11, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x400651 <.text+0x291>
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x8(%rbp)
               	jmp	0x400651 <.text+0x291>
               	movabsq	$0x400c000000000000, %r12 # imm = 0x400C000000000000
               	movq	%r12, %xmm14
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	movsd	0x28(%rsp), %xmm0
               	xorl	%eax, %eax
               	callq	0x4008df <fabs>
               	movq	%xmm0, %r8
               	movq	%r8, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x4006ce <.text+0x30e>
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	jmp	0x4006ce <.text+0x30e>
               	movabsq	$0x401c000000000000, %rbx # imm = 0x401C000000000000
               	movabsq	$0x4010000000000000, %r14 # imm = 0x4010000000000000
               	movq	%rbx, %xmm0
               	movq	%r14, %xmm1
               	xorl	%eax, %eax
               	callq	0x4008e5 <fmod>
               	movq	%xmm0, %r12
               	movabsq	$0x4008000000000000, %r14 # imm = 0x4008000000000000
               	movq	%r12, %xmm14
               	movq	%r14, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	0x40073d <.text+0x37d>
               	xorq	%r14, %r14
               	movl	%r14d, -0x8(%rbp)
               	jmp	0x40073d <.text+0x37d>
               	movslq	-0x8(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x40075c <.text+0x39c>
               	movl	$0xb, %ebx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x400768 <.text+0x3a8>
               	xorq	%rbx, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x400768 <.text+0x3a8>
               	movq	-0x48(%rbp), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	orb	(%r9), %cl
               	jbe	0x4007c3 <.text+0x403>
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
               	jae	0x40084a <.text+0x48a>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400841 <.text+0x481>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400845 <.text+0x485>
               	andb	%ch, 0x74(%rax)
               	je	0x400855 <.text+0x495>
               	jae	0x400821 <.text+0x461>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x40085d <.text+0x49d>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4008eb <exit>
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
               	jbe	0x40087b <.text+0x4bb>
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
               	jae	0x400902 <exit+0x17>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4008f9 <exit+0xe>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4008fd <exit+0x12>
               	andb	%ch, 0x74(%rax)
               	je	0x40090d <exit+0x22>
               	jae	0x4008d9 <ceil>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400915 <exit+0x2a>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf823(%rip)           # 0x4100f0

<sqrt>:
               	jmpq	*0xf825(%rip)           # 0x4100f8

<floor>:
               	jmpq	*0xf827(%rip)           # 0x410100

<ceil>:
               	jmpq	*0xf829(%rip)           # 0x410108

<fabs>:
               	jmpq	*0xf82b(%rip)           # 0x410110

<fmod>:
               	jmpq	*0xf82d(%rip)           # 0x410118

<exit>:
               	jmpq	*0xf82f(%rip)           # 0x410120
