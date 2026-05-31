
two_d_array_param_indexing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40049f <.text+0x21f>
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
               	callq	0x400997 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400399 <.text+0x119>
               	leaq	0xfd77(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400399 <.text+0x119>
               	leaq	0xfd58(%rip), %r12      # 0x4100f8
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
               	jmp	0x4004cc <.text+0x24c>
               	movslq	-0x408(%rbp), %r11
               	cmpq	$0x100, %r11            # imm = 0x100
               	jge	0x400551 <.text+0x2d1>
               	jmp	0x400501 <.text+0x281>
               	leaq	-0x408(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x4004cc <.text+0x24c>
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
               	jmp	0x4004e5 <.text+0x265>
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
               	callq	0x4003cd <.text+0x14d>
               	movl	$0x1244, %r12d          # imm = 0x1244
               	movslq	%r12d, %r12
               	cmpq	%r12, %rax
               	je	0x4005d8 <.text+0x358>
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
               	jmp	0x4005e6 <.text+0x366>
               	movslq	-0x408(%rbp), %rbx
               	cmpq	$0xa, %rbx
               	jge	0x400628 <.text+0x3a8>
               	jmp	0x40061a <.text+0x39a>
               	leaq	-0x408(%rbp), %rbx
               	movslq	(%rbx), %r12
               	movq	%r12, %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rbx)
               	jmp	0x4005e6 <.text+0x366>
               	xorq	%rax, %rax
               	movl	%eax, -0x488(%rbp)
               	jmp	0x400652 <.text+0x3d2>
               	leaq	-0x480(%rbp), %r14
               	movl	$0x7, %r12d
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	0x4003fc <.text+0x17c>
               	cmpq	$0x837, %rax            # imm = 0x837
               	je	0x400700 <.text+0x480>
               	jmp	0x4006d9 <.text+0x459>
               	movslq	-0x488(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	0x4006d4 <.text+0x454>
               	jmp	0x400686 <.text+0x406>
               	leaq	-0x488(%rbp), %rax
               	movslq	(%rax), %r12
               	movq	%r12, %rbx
               	addq	$0x1, %rbx
               	movl	%ebx, (%rax)
               	jmp	0x400652 <.text+0x3d2>
               	leaq	-0x480(%rbp), %rbx
               	movslq	-0x408(%rbp), %r12
               	movl	$0xc, %eax
               	imulq	%r12, %rax
               	movq	%rbx, %r8
               	addq	%rax, %r8
               	movslq	-0x488(%rbp), %rax
               	movq	%rax, %rbx
               	shlq	$0x2, %rbx
               	movq	%r8, %rsi
               	addq	%rbx, %rsi
               	movl	$0x64, %ebx
               	imulq	%r12, %rbx
               	movslq	%ebx, %rbx
               	movq	%rbx, %r12
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, (%rsi)
               	jmp	0x40066b <.text+0x3eb>
               	jmp	0x4005ff <.text+0x37f>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
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
               	jmp	0x40070f <.text+0x48f>
               	movslq	-0x408(%rbp), %r12
               	cmpq	$0x8, %r12
               	jge	0x400755 <.text+0x4d5>
               	jmp	0x400746 <.text+0x4c6>
               	leaq	-0x408(%rbp), %r12
               	movslq	(%r12), %rax
               	movq	%rax, %r14
               	addq	$0x1, %r14
               	movl	%r14d, (%r12)
               	jmp	0x40070f <.text+0x48f>
               	xorq	%r14, %r14
               	movl	%r14d, -0x488(%rbp)
               	jmp	0x40077f <.text+0x4ff>
               	leaq	-0x4a8(%rbp), %rbx
               	movl	$0x3, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x400442 <.text+0x1c2>
               	cmpq	$0x116, %rax            # imm = 0x116
               	je	0x400831 <.text+0x5b1>
               	jmp	0x40080a <.text+0x58a>
               	movslq	-0x488(%rbp), %r14
               	cmpq	$0x4, %r14
               	jge	0x400805 <.text+0x585>
               	jmp	0x4007b4 <.text+0x534>
               	leaq	-0x488(%rbp), %r14
               	movslq	(%r14), %rax
               	movq	%rax, %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%r14)
               	jmp	0x40077f <.text+0x4ff>
               	leaq	-0x4a8(%rbp), %r12
               	movslq	-0x408(%rbp), %rax
               	movq	%rax, %r14
               	shlq	$0x2, %r14
               	movq	%r12, %rsi
               	addq	%r14, %rsi
               	movslq	-0x488(%rbp), %r14
               	movq	%rsi, %r12
               	addq	%r14, %r12
               	movq	%rax, %rsi
               	addq	$0x41, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	addq	%r14, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r12)
               	jmp	0x400798 <.text+0x518>
               	jmp	0x400728 <.text+0x4a8>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
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
               	addb	%al, 0x41(%rdx)
