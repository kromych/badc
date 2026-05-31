
mcpy_temp_aliases_src.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%r12, (%rsp)
               	movq	%r14, 0x8(%rsp)
               	movq	%r15, 0x10(%rsp)
               	movl	$0x1, %r11d
               	movl	$0x2, %r9d
               	movl	$0x3, %r8d
               	movl	$0x4, %edi
               	movl	$0x5, %esi
               	movl	$0x6, %edx
               	movl	$0x7, %ecx
               	movl	$0x8, %eax
               	movl	$0x9, %r15d
               	movl	$0xa, %r14d
               	movslq	%r11d, %r12
               	movslq	%r9d, %r11
               	movq	%r12, %r9
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	movslq	%r8d, %r11
               	movq	%r9, %r8
               	addq	%r11, %r8
               	movslq	%r8d, %r8
               	movslq	%edi, %r11
               	movq	%r8, %rdi
               	addq	%r11, %rdi
               	movslq	%edi, %rdi
               	movslq	%esi, %r11
               	movq	%rdi, %rsi
               	addq	%r11, %rsi
               	movslq	%esi, %rsi
               	movslq	%edx, %r11
               	movq	%rsi, %rdx
               	addq	%r11, %rdx
               	movslq	%edx, %rdx
               	movslq	%ecx, %r11
               	movq	%rdx, %rcx
               	addq	%r11, %rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %r11
               	movq	%rcx, %rax
               	addq	%r11, %rax
               	movslq	%eax, %rax
               	movslq	%r15d, %r11
               	movq	%rax, %r15
               	addq	%r11, %r15
               	movslq	%r15d, %r15
               	movslq	%r14d, %r11
               	movq	%r15, %r14
               	addq	%r11, %r14
               	movslq	%r14d, %r14
               	leaq	-0x20(%rbp), %r11
               	leaq	0xfdcf(%rip), %r15      # 0x4100d0
               	pushq	%rax
               	movq	(%r15), %rax
               	movq	%rax, (%r11)
               	movq	0x8(%r15), %rax
               	movq	%rax, 0x8(%r11)
               	movq	0x10(%r15), %rax
               	movq	%rax, 0x10(%r11)
               	movq	0x18(%r15), %rax
               	movq	%rax, 0x18(%r11)
               	popq	%rax
               	movq	%r11, %rax
               	movslq	%r14d, %rax
               	cmpq	$0x37, %rax
               	je	0x400356 <.text+0x136>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r14
               	movq	(%r14), %rax
               	cmpq	$0x1111, %rax           # imm = 0x1111
               	je	0x40038c <.text+0x16c>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r14
               	cmpq	$0x2222, %r14           # imm = 0x2222
               	je	0x4003cd <.text+0x1ad>
               	movl	$0x3, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %r14
               	addq	$0x10, %r14
               	movq	(%r14), %rax
               	cmpq	$0x3333, %rax           # imm = 0x3333
               	je	0x40040d <.text+0x1ed>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r14
               	movq	%r14, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %r14
               	cmpq	$0x4444, %r14           # imm = 0x4444
               	je	0x40044e <.text+0x22e>
               	movl	$0x5, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x4004a7 <.text+0x287>
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
               	jae	0x40052e <.text+0x30e>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400525 <.text+0x305>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400529 <.text+0x309>
               	andb	%ch, 0x74(%rax)
               	je	0x400539 <.text+0x319>
               	jae	0x400505 <.text+0x2e5>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400541 <.text+0x321>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
		...
               	addb	%dl, 0x48(%rbp)
               	movl	%esp, %ebp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4005b7 <exit>
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
               	jbe	0x40056b <.text+0x34b>
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
               	jae	0x4005f2 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4005e9 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4005ed <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x4005fd <exit+0x46>
               	jae	0x4005c9 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400605 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfb03(%rip)           # 0x4100c0
