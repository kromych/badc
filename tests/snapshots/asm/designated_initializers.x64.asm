
designated_initializers.x64:	file format elf64-x86-64

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
               	callq	0x400c07 <dlsym>
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
               	subq	$0xc0, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	0xfd62(%rip), %r9       # 0x410148
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	cmpq	$0x1, %r9
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x90(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x400447 <.text+0x1c7>
               	leaq	-0x8(%rbp), %r9
               	movq	%r9, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r9
               	cmpq	$0x2, %r9
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x90(%rbp)
               	jmp	0x400447 <.text+0x1c7>
               	movq	-0x90(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x400469 <.text+0x1e9>
               	movl	$0x1, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r8
               	leaq	0xfcdc(%rip), %rax      # 0x410150
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r8)
               	popq	%r11
               	movq	%r8, %r11
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %rax
               	cmpq	$0xa, %rax
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x98(%rbp)
               	cmpq	$0x0, %r11
               	jne	0x4004d7 <.text+0x257>
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x14, %rax
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x98(%rbp)
               	jmp	0x4004d7 <.text+0x257>
               	movq	-0x98(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x4004f9 <.text+0x279>
               	movl	$0x2, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	leaq	0xfc54(%rip), %rax      # 0x410158
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r11)
               	popq	%rcx
               	movq	%r11, %r8
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %rax
               	cmpq	$0x0, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xa0(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x400565 <.text+0x2e5>
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %rax
               	cmpq	$0x63, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xa0(%rbp)
               	jmp	0x400565 <.text+0x2e5>
               	movq	-0xa0(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x400587 <.text+0x307>
               	movl	$0x3, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %r8
               	leaq	0xfbce(%rip), %rax      # 0x410160
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r8)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%r8)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%r8)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%r8)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%r8)
               	popq	%r11
               	movq	%r8, %r11
               	leaq	-0x28(%rbp), %r11
               	movslq	(%r11), %rax
               	cmpq	$0x1, %rax
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xb0(%rbp)
               	cmpq	$0x0, %r11
               	jne	0x400619 <.text+0x399>
               	leaq	-0x28(%rbp), %rax
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x2, %rax
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xb0(%rbp)
               	jmp	0x400619 <.text+0x399>
               	movq	-0xb0(%rbp), %r11
               	movq	%r11, -0xa8(%rbp)
               	cmpq	$0x0, %r11
               	jne	0x400660 <.text+0x3e0>
               	leaq	-0x28(%rbp), %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x3, %rax
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xa8(%rbp)
               	jmp	0x400660 <.text+0x3e0>
               	movq	-0xa8(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400682 <.text+0x402>
               	movl	$0x4, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r11
               	leaq	0xfadf(%rip), %rax      # 0x41016c
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r11)
               	popq	%rcx
               	movq	%r11, %r8
               	leaq	-0x30(%rbp), %r8
               	movslq	(%r8), %rax
               	cmpq	$0x7, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xb8(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x4006ee <.text+0x46e>
               	leaq	-0x30(%rbp), %rax
               	movq	%rax, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %rax
               	cmpq	$0xe, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xb8(%rbp)
               	jmp	0x4006ee <.text+0x46e>
               	movq	-0xb8(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x400710 <.text+0x490>
               	movl	$0x5, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %r8
               	leaq	0xfa59(%rip), %rax      # 0x410174
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r8)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%r8)
               	movzbq	0x10(%rax), %r11
               	movb	%r11b, 0x10(%r8)
               	movzbq	0x11(%rax), %r11
               	movb	%r11b, 0x11(%r8)
               	movzbq	0x12(%rax), %r11
               	movb	%r11b, 0x12(%r8)
               	movzbq	0x13(%rax), %r11
               	movb	%r11b, 0x13(%r8)
               	popq	%r11
               	movq	%r8, %r11
               	leaq	-0x48(%rbp), %r11
               	movslq	(%r11), %rax
               	cmpq	$0xa, %rax
               	je	0x400776 <.text+0x4f6>
               	movl	$0xb, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %r11
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x4007a6 <.text+0x526>
               	movl	$0xc, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x0, %rax
               	je	0x4007d2 <.text+0x552>
               	movl	$0xd, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %r11
               	movq	%r11, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x400802 <.text+0x582>
               	movl	$0xe, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movq	%rax, %r11
               	addq	$0x10, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x32, %rax
               	je	0x40082e <.text+0x5ae>
               	movl	$0xf, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	leaq	0xf94f(%rip), %rax      # 0x410188
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r11)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r11)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%r11)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%r11)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%r11)
               	popq	%rcx
               	movq	%r11, %r8
               	leaq	-0x70(%rbp), %r8
               	movslq	(%r8), %rax
               	cmpq	$0x0, %rax
               	je	0x400886 <.text+0x606>
               	movl	$0x15, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r8
               	cmpq	$0xc8, %r8
               	je	0x4008b6 <.text+0x636>
               	movl	$0x16, %r8d
               	movq	%r8, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	%rax, %r8
               	addq	$0x14, %r8
               	movslq	(%r8), %rax
               	cmpq	$0x0, %rax
               	je	0x4008e2 <.text+0x662>
               	movl	$0x17, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x1c, %rax
               	movslq	(%rax), %r8
               	cmpq	$0x2bc, %r8             # imm = 0x2BC
               	je	0x400912 <.text+0x692>
               	movl	$0x18, %r8d
               	movq	%r8, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	%rax, %r8
               	addq	$0x20, %r8
               	movslq	(%r8), %rax
               	cmpq	$0x0, %rax
               	je	0x40093e <.text+0x6be>
               	movl	$0x19, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x24, %rax
               	movslq	(%rax), %r8
               	cmpq	$0x384, %r8             # imm = 0x384
               	je	0x40096e <.text+0x6ee>
               	movl	$0x1a, %r8d
               	movq	%r8, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	leaq	0xf834(%rip), %r8       # 0x4101b0
               	pushq	%r11
               	movq	(%r8), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%r8), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%r8), %r11
               	movq	%r11, 0x10(%rax)
               	popq	%r11
               	movq	%rax, %r11
               	leaq	-0x88(%rbp), %r11
               	movslq	(%r11), %r8
               	cmpq	$0x1, %r8
               	je	0x4009be <.text+0x73e>
               	movl	$0x1f, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %r11
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x2, %r11
               	je	0x4009f1 <.text+0x771>
               	movl	$0x20, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x0, %rax
               	je	0x400a20 <.text+0x7a0>
               	movl	$0x21, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %r11
               	movq	%r11, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x400a53 <.text+0x7d3>
               	movl	$0x22, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	movq	%rax, %r11
               	addq	$0x10, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x32, %rax
               	je	0x400a82 <.text+0x802>
               	movl	$0x23, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %r11
               	movq	%r11, %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x3c, %r11
               	je	0x400ab5 <.text+0x835>
               	movl	$0x24, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
