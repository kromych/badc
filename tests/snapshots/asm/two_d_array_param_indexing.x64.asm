
two_d_array_param_indexing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4004a2 <.text+0x222>
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
               	callq	0x4009a7 <dlsym>
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
               	movslq	%esi, %r9
               	movq	%r9, %r8
               	shlq	$0x2, %r8
               	movq	%r11, %r9
               	addq	%r8, %r9
               	movzwq	(%r9), %r8
               	movq	%r9, %r11
               	addq	$0x2, %r11
               	movzwq	(%r11), %r9
               	movq	%r8, %r11
               	addq	%r9, %r11
               	movslq	%r11d, %rax
               	retq
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	movl	$0xc, %r8d
               	imulq	%r9, %r8
               	movq	%r11, %r9
               	addq	%r8, %r9
               	movslq	(%r9), %r8
               	movq	%r9, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rdi
               	movq	%r8, %r11
               	addq	%rdi, %r11
               	movslq	%r11d, %r11
               	movq	%r9, %rdi
               	addq	$0x8, %rdi
               	movslq	(%rdi), %r9
               	movq	%r11, %rdi
               	addq	%r9, %rdi
               	movslq	%edi, %rax
               	retq
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	movq	%r9, %r8
               	shlq	$0x2, %r8
               	movq	%r11, %r9
               	addq	%r8, %r9
               	movzbq	(%r9), %r8
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %rdi
               	movq	%r8, %r11
               	addq	%rdi, %r11
               	movslq	%r11d, %r11
               	movq	%r9, %rdi
               	addq	$0x2, %rdi
               	movzbq	(%rdi), %r8
               	movq	%r11, %rdi
               	addq	%r8, %rdi
               	movslq	%edi, %rdi
               	movq	%r9, %r8
               	addq	$0x3, %r8
               	movzbq	(%r8), %r9
               	movq	%rdi, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x4e0, %rsp            # imm = 0x4E0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x408(%rbp)
               	jmp	0x4004cf <.text+0x24f>
               	movslq	-0x408(%rbp), %r11
               	cmpq	$0x100, %r11            # imm = 0x100
               	jge	0x400554 <.text+0x2d4>
               	jmp	0x400504 <.text+0x284>
               	leaq	-0x408(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x4004cf <.text+0x24f>
               	leaq	-0x400(%rbp), %r8
               	movslq	-0x408(%rbp), %r9
               	movq	%r9, %r11
               	shlq	$0x2, %r11
               	movq	%r8, %r9
               	addq	%r11, %r9
               	xorq	%r11, %r11
               	movw	%r11w, (%r9)
               	leaq	-0x400(%rbp), %r8
               	movslq	-0x408(%rbp), %r9
               	movq	%r9, %rdi
               	shlq	$0x2, %rdi
               	movq	%r8, %r9
               	addq	%rdi, %r9
               	movq	%r9, %rdi
               	addq	$0x2, %rdi
               	movw	%r11w, (%rdi)
               	jmp	0x4004e8 <.text+0x268>
               	leaq	-0x400(%rbp), %rdi
               	movq	%rdi, %r9
               	addq	$0x14, %r9
               	movl	$0x1234, %edi           # imm = 0x1234
               	movw	%di, (%r9)
               	leaq	-0x400(%rbp), %r11
               	movq	%r11, %rdi
               	addq	$0x16, %rdi
               	movl	$0x10, %r11d
               	movw	%r11w, (%rdi)
               	leaq	-0x400(%rbp), %rbx
               	movl	$0x5, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x4003d0 <.text+0x150>
               	movq	%rax, %rdi
               	movl	$0x1244, %r12d          # imm = 0x1244
               	movslq	%r12d, %r12
               	cmpq	%r12, %rdi
               	je	0x4005de <.text+0x35e>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x4e0, %rsp            # imm = 0x4E0
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x408(%rbp)
               	jmp	0x4005ec <.text+0x36c>
               	movslq	-0x408(%rbp), %rbx
               	cmpq	$0xa, %rbx
               	jge	0x40062e <.text+0x3ae>
               	jmp	0x400620 <.text+0x3a0>
               	leaq	-0x408(%rbp), %rbx
               	movslq	(%rbx), %r12
               	movq	%r12, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%rbx)
               	jmp	0x4005ec <.text+0x36c>
               	xorq	%rdi, %rdi
               	movl	%edi, -0x488(%rbp)
               	jmp	0x40065b <.text+0x3db>
               	leaq	-0x480(%rbp), %r14
               	movl	$0x7, %r12d
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	0x4003ff <.text+0x17f>
               	movq	%rax, %rsi
               	cmpq	$0x837, %rsi            # imm = 0x837
               	je	0x400709 <.text+0x489>
               	jmp	0x4006e2 <.text+0x462>
               	movslq	-0x488(%rbp), %rdi
               	cmpq	$0x3, %rdi
               	jge	0x4006dd <.text+0x45d>
               	jmp	0x40068f <.text+0x40f>
               	leaq	-0x488(%rbp), %rdi
               	movslq	(%rdi), %r12
               	movq	%r12, %rbx
               	addq	$0x1, %rbx
               	movl	%ebx, (%rdi)
               	jmp	0x40065b <.text+0x3db>
               	leaq	-0x480(%rbp), %rbx
               	movslq	-0x408(%rbp), %r12
               	movl	$0xc, %edi
               	imulq	%r12, %rdi
               	movq	%rbx, %r8
               	addq	%rdi, %r8
               	movslq	-0x488(%rbp), %rdi
               	movq	%rdi, %rbx
               	shlq	$0x2, %rbx
               	movq	%r8, %rsi
               	addq	%rbx, %rsi
               	movl	$0x64, %ebx
               	imulq	%r12, %rbx
               	movslq	%ebx, %rbx
               	movq	%rbx, %r12
               	addq	%rdi, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, (%rsi)
               	jmp	0x400674 <.text+0x3f4>
               	jmp	0x400605 <.text+0x385>
               	movl	$0x2, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x4e0, %rsp            # imm = 0x4E0
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movl	%r12d, -0x408(%rbp)
               	jmp	0x400718 <.text+0x498>
               	movslq	-0x408(%rbp), %r12
               	cmpq	$0x8, %r12
               	jge	0x40075e <.text+0x4de>
               	jmp	0x40074f <.text+0x4cf>
               	leaq	-0x408(%rbp), %r12
               	movslq	(%r12), %rsi
               	movq	%rsi, %r14
               	addq	$0x1, %r14
               	movl	%r14d, (%r12)
               	jmp	0x400718 <.text+0x498>
               	xorq	%r14, %r14
               	movl	%r14d, -0x488(%rbp)
               	jmp	0x40078b <.text+0x50b>
               	leaq	-0x4a8(%rbp), %rbx
               	movl	$0x3, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x400445 <.text+0x1c5>
               	movq	%rax, %r12
               	cmpq	$0x116, %r12            # imm = 0x116
               	je	0x40083e <.text+0x5be>
               	jmp	0x400816 <.text+0x596>
               	movslq	-0x488(%rbp), %r14
               	cmpq	$0x4, %r14
               	jge	0x400811 <.text+0x591>
               	jmp	0x4007c0 <.text+0x540>
               	leaq	-0x488(%rbp), %r14
               	movslq	(%r14), %rsi
               	movq	%rsi, %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%r14)
               	jmp	0x40078b <.text+0x50b>
               	leaq	-0x4a8(%rbp), %r12
               	movslq	-0x408(%rbp), %rsi
               	movq	%rsi, %r14
               	shlq	$0x2, %r14
               	movq	%r12, %rdi
               	addq	%r14, %rdi
               	movslq	-0x488(%rbp), %r14
               	movq	%rdi, %r12
               	addq	%r14, %r12
               	movq	%rsi, %rdi
               	addq	$0x41, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %rsi
               	addq	%r14, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r12)
               	jmp	0x4007a4 <.text+0x524>
               	jmp	0x400731 <.text+0x4b1>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x4e0, %rsp            # imm = 0x4E0
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x4e0, %rsp            # imm = 0x4E0
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x40089b <.text+0x61b>
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
               	jae	0x400922 <.text+0x6a2>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400919 <.text+0x699>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40091d <.text+0x69d>
               	andb	%ch, 0x74(%rax)
               	je	0x40092d <.text+0x6ad>
               	jae	0x4008f9 <.text+0x679>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400935 <.text+0x6b5>
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
               	callq	0x4009ad <exit>
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
               	jbe	0x40095b <.text+0x6db>
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
               	jae	0x4009e2 <exit+0x35>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4009d9 <exit+0x2c>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4009dd <exit+0x30>
               	andb	%ch, 0x74(%rax)
               	je	0x4009ed <exit+0x40>
               	jae	0x4009b9 <exit+0xc>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4009f5 <exit+0x48>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf733(%rip)           # 0x4100e0

<exit>:
               	jmpq	*0xf735(%rip)           # 0x4100e8
