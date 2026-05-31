
fp_nan_unordered_compare.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003d0 <.text+0x150>
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
               	callq	0x400b87 <dlsym>
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%r11, %r11
               	movq	%r11, %xmm7
               	movq	%r11, %xmm15
               	divsd	%xmm15, %xmm7
               	movq	%xmm7, %r10
               	movq	%r10, -0x10(%rbp)
               	movabsq	$0x4014000000000000, %r9 # imm = 0x4014000000000000
               	movabsq	$0x3ff0000000000000, %r8 # imm = 0x3FF0000000000000
               	movq	%r8, %xmm7
               	movq	%r11, %xmm15
               	divsd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x20(%rbp)
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	jne	0x400463 <.text+0x1e3>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	0x4004a4 <.text+0x224>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r9, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	0x4004e5 <.text+0x265>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	xorq	%rax, %rax
               	movq	%r8, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%dil
               	movzbq	%dil, %rdi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x40052c <.text+0x2ac>
               	movl	$0x4, %edi
               	movq	%rdi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%dil
               	movzbq	%dil, %rdi
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x40056d <.text+0x2ed>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rdi
               	movq	%rdi, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4005b1 <.text+0x331>
               	movl	$0xb, %edi
               	movq	%rdi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%dil
               	movzbq	%dil, %rdi
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x4005f2 <.text+0x372>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x400636 <.text+0x3b6>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40067b <.text+0x3fb>
               	movl	$0x14, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	0x4006b1 <.text+0x431>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4006f6 <.text+0x476>
               	movl	$0x16, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	0x40072c <.text+0x4ac>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r9, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400771 <.text+0x4f1>
               	movl	$0x18, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	0x4007a7 <.text+0x527>
               	movl	$0x19, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r9, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4007ec <.text+0x56c>
               	movl	$0x1a, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	0x400822 <.text+0x5a2>
               	movl	$0x1b, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400867 <.text+0x5e7>
               	movl	$0x1c, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x4008a8 <.text+0x628>
               	movl	$0x1d, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	je	0x4008e2 <.text+0x662>
               	movl	$0x1e, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	jne	0x40092d <.text+0x6ad>
               	movl	$0x28, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%r9, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	jne	0x400978 <.text+0x6f8>
               	movl	$0x29, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x20(%rbp), %rax
               	movq	%rax, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x4009b2 <.text+0x732>
               	movl	$0x2a, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x20(%rbp), %rax
               	movabsq	$0x7e37e43c8800759c, %r8 # imm = 0x7E37E43C8800759C
               	movq	%rax, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x0, %r9
               	jne	0x4009f2 <.text+0x772>
               	movl	$0x2b, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x20(%rbp), %r8
               	movq	%r8, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400a37 <.text+0x7b7>
               	movl	$0x2c, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x400a7b <.text+0x7fb>
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
               	jae	0x400b02 <.text+0x882>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400af9 <.text+0x879>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400afd <.text+0x87d>
               	andb	%ch, 0x74(%rax)
               	je	0x400b0d <.text+0x88d>
               	jae	0x400ad9 <.text+0x859>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400b15 <.text+0x895>
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
               	callq	0x400b8d <exit>
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
               	jbe	0x400b3b <.text+0x8bb>
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
               	jae	0x400bc2 <exit+0x35>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400bb9 <exit+0x2c>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400bbd <exit+0x30>
               	andb	%ch, 0x74(%rax)
               	je	0x400bcd <exit+0x40>
               	jae	0x400b99 <exit+0xc>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400bd5 <exit+0x48>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf553(%rip)           # 0x4100e0

<exit>:
               	jmpq	*0xf555(%rip)           # 0x4100e8
