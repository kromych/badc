
switch_nested_case_in_compound.x64:	file format elf64-x86-64

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
               	callq	0x400857 <dlsym>
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
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	$0x2, %r9d
               	movslq	%r9d, %r11
               	jmp	0x4004e7 <.text+0x227>
               	movslq	-0x8(%rbp), %r9
               	cmpq	$0x7, %r9
               	je	0x40058f <.text+0x2cf>
               	jmp	0x40054a <.text+0x28a>
               	movl	$0x64, %r8d
               	movl	%r8d, -0x18(%rbp)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	movslq	-0x18(%rbp), %r11
               	movq	%r8, %rdi
               	addq	%r11, %rdi
               	movl	%edi, (%r9)
               	movslq	-0x18(%rbp), %r11
               	cmpq	$0x64, %r11
               	jne	0x400531 <.text+0x271>
               	jmp	0x400513 <.text+0x253>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %rdi
               	movq	%rdi, %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x8(%rbp), %rdi
               	movslq	(%rdi), %r9
               	movq	%r9, %r11
               	addq	$0x2, %r11
               	movl	%r11d, (%rdi)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r11
               	movq	%r11, %rdi
               	addq	$0x4, %rdi
               	movl	%edi, (%r9)
               	jmp	0x400443 <.text+0x183>
               	leaq	-0x8(%rbp), %rdi
               	movslq	(%rdi), %r11
               	movq	%r11, %r9
               	orq	$0x4000, %r9            # imm = 0x4000
               	movl	%r9d, (%rdi)
               	jmp	0x400443 <.text+0x183>
               	cmpq	$0x1, %r11
               	je	0x400459 <.text+0x199>
               	cmpq	$0x2, %r11
               	je	0x40048d <.text+0x1cd>
               	cmpq	$0x3, %r11
               	je	0x4004ce <.text+0x20e>
               	jmp	0x400443 <.text+0x183>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %rdi
               	movq	%rdi, %r9
               	orq	$0x1000, %r9            # imm = 0x1000
               	movl	%r9d, (%r11)
               	jmp	0x40052c <.text+0x26c>
               	jmp	0x40048d <.text+0x1cd>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %rdi
               	movq	%rdi, %r11
               	orq	$0x2000, %r11           # imm = 0x2000
               	movl	%r11d, (%r9)
               	jmp	0x400443 <.text+0x183>
               	leaq	0xfbff(%rip), %rbx      # 0x410150
               	movslq	-0x8(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40085d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movl	$0x1, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movl	%r12d, -0x8(%rbp)
               	movl	$0x1, %edi
               	movslq	%edi, %r12
               	jmp	0x400647 <.text+0x387>
               	movslq	-0x8(%rbp), %rdi
               	cmpq	$0x106b, %rdi           # imm = 0x106B
               	je	0x4006f2 <.text+0x432>
               	jmp	0x4006ac <.text+0x3ec>
               	movl	$0x64, %ebx
               	movl	%ebx, -0x20(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movslq	(%rdi), %rbx
               	movslq	-0x20(%rbp), %r12
               	movq	%rbx, %r8
               	addq	%r12, %r8
               	movl	%r8d, (%rdi)
               	movslq	-0x20(%rbp), %r12
               	cmpq	$0x64, %r12
               	jne	0x400693 <.text+0x3d3>
               	jmp	0x400673 <.text+0x3b3>
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r8
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r12)
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %rdi
               	movq	%rdi, %r12
               	addq	$0x2, %r12
               	movl	%r12d, (%r8)
               	leaq	-0x8(%rbp), %rdi
               	movslq	(%rdi), %r12
               	movq	%r12, %r8
               	addq	$0x4, %r8
               	movl	%r8d, (%rdi)
               	jmp	0x4005a3 <.text+0x2e3>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r12
               	movq	%r12, %rdi
               	orq	$0x4000, %rdi           # imm = 0x4000
               	movl	%edi, (%r8)
               	jmp	0x4005a3 <.text+0x2e3>
               	cmpq	$0x1, %r12
               	je	0x4005b9 <.text+0x2f9>
               	cmpq	$0x2, %r12
               	je	0x4005eb <.text+0x32b>
               	cmpq	$0x3, %r12
               	je	0x40062e <.text+0x36e>
               	jmp	0x4005a3 <.text+0x2e3>
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r8
               	movq	%r8, %rdi
               	orq	$0x1000, %rdi           # imm = 0x1000
               	movl	%edi, (%r12)
               	jmp	0x40068e <.text+0x3ce>
               	jmp	0x4005eb <.text+0x32b>
               	leaq	-0x8(%rbp), %rdi
               	movslq	(%rdi), %r8
               	movq	%r8, %r12
               	orq	$0x2000, %r12           # imm = 0x2000
               	movl	%r12d, (%rdi)
               	jmp	0x4005a3 <.text+0x2e3>
               	leaq	0xfab2(%rip), %r14      # 0x410165
               	movslq	-0x8(%rbp), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40085d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x2, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x40074f <.text+0x48f>
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
               	jae	0x4007d6 <.text+0x516>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4007cd <.text+0x50d>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4007d1 <.text+0x511>
               	andb	%ch, 0x74(%rax)
               	je	0x4007e1 <.text+0x521>
               	jae	0x4007ad <.text+0x4ed>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4007e9 <.text+0x529>
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
               	callq	0x400863 <exit>
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
               	jbe	0x40080b <.text+0x54b>
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
               	jae	0x400892 <exit+0x2f>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400889 <exit+0x26>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40088d <exit+0x2a>
               	andb	%ch, 0x74(%rax)
               	je	0x40089d <exit+0x3a>
               	jae	0x400869 <exit+0x6>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4008a5 <exit+0x42>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf883(%rip)           # 0x4100e0

<printf>:
               	jmpq	*0xf885(%rip)           # 0x4100e8

<exit>:
               	jmpq	*0xf887(%rip)           # 0x4100f0
