
local_array_runtime_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4006a2 <.text+0x422>
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
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400305 <.text+0x85>
               	leaq	0xfe1d(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
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
               	leaq	0xfdfd(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdee(%rip), %rdi      # 0x410116
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfde0(%rip), %rdi      # 0x41011d
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400b27 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400387 <.text+0x107>
               	leaq	0xfd86(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x400387 <.text+0x107>
               	leaq	0xfd6a(%rip), %r12      # 0x4100f8
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	leaq	-0x8(%rbp), %r9
               	leaq	0x10179(%rip), %r8      # 0x410548
               	pushq	%rax
               	movzbq	(%r8), %rax
               	movb	%al, (%r9)
               	movzbq	0x1(%r8), %rax
               	movb	%al, 0x1(%r9)
               	movzbq	0x2(%r8), %rax
               	movb	%al, 0x2(%r9)
               	movzbq	0x3(%r8), %rax
               	movb	%al, 0x3(%r9)
               	popq	%rax
               	movq	%r9, %rdi
               	leaq	0xfd4b(%rip), %rdi      # 0x410148
               	movq	%r11, %r8
               	shlq	$0x1, %r8
               	addq	%r8, %rdi
               	movzwq	(%rdi), %r8
               	leaq	-0x8(%rbp), %rdi
               	movw	%r8w, (%rdi)
               	leaq	0xff2e(%rip), %r9       # 0x410348
               	shlq	$0x1, %r11
               	addq	%r11, %r9
               	movzwq	(%r9), %r11
               	leaq	-0x8(%rbp), %r9
               	addq	$0x2, %r9
               	movw	%r11w, (%r9)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %r9
               	movl	$0x3e8, %r11d           # imm = 0x3E8
               	imulq	%r11, %r9
               	movslq	%r9d, %r9
               	leaq	-0x8(%rbp), %rdi
               	addq	$0x2, %rdi
               	movzwq	(%rdi), %r11
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	leaq	-0x10(%rbp), %r8
               	leaq	0x100c9(%rip), %rdi     # 0x41054c
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%r8)
               	movzbq	0x8(%rdi), %rax
               	movb	%al, 0x8(%r8)
               	movzbq	0x9(%rdi), %rax
               	movb	%al, 0x9(%r8)
               	movzbq	0xa(%rdi), %rax
               	movb	%al, 0xa(%r8)
               	movzbq	0xb(%rdi), %rax
               	movb	%al, 0xb(%r8)
               	popq	%rax
               	movq	%r8, %rsi
               	movq	%r11, %rsi
               	addq	%r9, %rsi
               	movslq	%esi, %rsi
               	leaq	-0x10(%rbp), %rdi
               	movl	%esi, (%rdi)
               	movq	%r11, %r8
               	subq	%r9, %r8
               	movslq	%r8d, %r8
               	leaq	-0x10(%rbp), %rdi
               	addq	$0x4, %rdi
               	movl	%r8d, (%rdi)
               	imulq	%r9, %r11
               	movslq	%r11d, %r11
               	leaq	-0x10(%rbp), %r9
               	addq	$0x8, %r9
               	movl	%r11d, (%r9)
               	leaq	-0x10(%rbp), %rsi
               	movslq	(%rsi), %r9
               	leaq	-0x10(%rbp), %rsi
               	addq	$0x4, %rsi
               	movslq	(%rsi), %r11
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	leaq	-0x10(%rbp), %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rsi
               	addq	%rsi, %r9
               	movslq	%r9d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	leaq	-0x10(%rbp), %r8
               	leaq	0x10017(%rip), %rdi     # 0x410558
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%r8)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%r8)
               	popq	%rax
               	movq	%r8, %rsi
               	movq	%r11, %rsi
               	addq	%r9, %rsi
               	leaq	-0x10(%rbp), %rdi
               	movq	%rsi, (%rdi)
               	subq	%r9, %r11
               	leaq	-0x10(%rbp), %r9
               	addq	$0x8, %r9
               	movq	%r11, (%r9)
               	leaq	-0x10(%rbp), %r8
               	movq	(%r8), %r9
               	leaq	-0x10(%rbp), %r8
               	addq	$0x8, %r8
               	movq	(%r8), %r11
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %r11
               	leaq	-0x8(%rbp), %r9
               	leaq	0xffb9(%rip), %r8       # 0x410568
               	pushq	%rax
               	movzbq	(%r8), %rax
               	movb	%al, (%r9)
               	movzbq	0x1(%r8), %rax
               	movb	%al, 0x1(%r9)
               	movzbq	0x2(%r8), %rax
               	movb	%al, 0x2(%r9)
               	movzbq	0x3(%r8), %rax
               	movb	%al, 0x3(%r9)
               	popq	%rax
               	movq	%r9, %rdi
               	movq	%r11, %rdi
               	addq	$0x61, %rdi
               	movslq	%edi, %rdi
               	andq	$0xff, %rdi
               	leaq	-0x8(%rbp), %r8
               	movb	%dil, (%r8)
               	movl	$0x62, %r9d
               	leaq	-0x8(%rbp), %r8
               	addq	$0x1, %r8
               	movb	%r9b, (%r8)
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	andq	$0xff, %r11
               	leaq	-0x8(%rbp), %rdi
               	addq	$0x2, %rdi
               	movb	%r11b, (%rdi)
               	movl	$0x64, %r8d
               	leaq	-0x8(%rbp), %rdi
               	addq	$0x3, %rdi
               	movb	%r8b, (%rdi)
               	xorq	%r11, %r11
               	movl	%r11d, -0x10(%rbp)
               	movl	%r11d, -0x18(%rbp)
               	jmp	0x400648 <.text+0x3c8>
               	movslq	-0x18(%rbp), %r11
               	cmpq	$0x4, %r11
               	jge	0x400695 <.text+0x415>
               	jmp	0x400674 <.text+0x3f4>
               	leaq	-0x18(%rbp), %rdi
               	movslq	(%rdi), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%rdi)
               	jmp	0x400648 <.text+0x3c8>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r8
               	leaq	-0x8(%rbp), %rdi
               	movslq	-0x18(%rbp), %r9
               	addq	%r9, %rdi
               	movzbq	(%rdi), %r9
               	addq	%r9, %r8
               	movl	%r8d, (%r11)
               	jmp	0x40065e <.text+0x3de>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xfa81(%rip), %r11      # 0x410148
               	addq	$0xa, %r11
               	movl	$0x1234, %r9d           # imm = 0x1234
               	movw	%r9w, (%r11)
               	leaq	0xfc69(%rip), %r8       # 0x410348
               	addq	$0xa, %r8
               	movl	$0x5678, %r9d           # imm = 0x5678
               	movw	%r9w, (%r8)
               	movl	$0x5, %ebx
               	movq	%rbx, %rdi
               	callq	0x4003b6 <.text+0x136>
               	movl	$0x471b20, %ebx         # imm = 0x471B20
               	movslq	%ebx, %rbx
               	addq	$0x5678, %rbx           # imm = 0x5678
               	movslq	%ebx, %rbx
               	cmpq	%rbx, %rax
               	je	0x40073f <.text+0x4bf>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %r12d
               	movl	$0x4, %r14d
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	0x400467 <.text+0x1e7>
               	cmpq	$0x12, %rax
               	je	0x40078b <.text+0x50b>
               	movl	$0x2, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %ebx
               	movl	$0x4, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x400525 <.text+0x2a5>
               	cmpq	$0x14, %rax
               	je	0x4007d6 <.text+0x556>
               	movl	$0x3, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400596 <.text+0x316>
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	0x400819 <.text+0x599>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	0xfd48(%rip), %r12      # 0x41056c
               	pushq	%r11
               	movq	(%r12), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%r12), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%r12), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%r12), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%r12), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	movq	%rax, %rbx
               	leaq	-0x10(%rbp), %rbx
               	movslq	(%rbx), %r12
               	leaq	-0x10(%rbp), %rbx
               	addq	$0x4, %rbx
               	movslq	(%rbx), %rax
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rbx
               	addq	%rbx, %r12
               	movslq	%r12d, %r12
               	cmpq	$0x6, %r12
               	je	0x4008bd <.text+0x63d>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r12
               	leaq	0xfcb6(%rip), %rbx      # 0x41057e
               	pushq	%rax
               	movq	(%rbx), %rax
               	movq	%rax, (%r12)
               	popq	%rax
               	movq	%r12, %rax
               	leaq	-0x18(%rbp), %rax
               	movzbq	(%rax), %rbx
               	xorq	$0x68, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x28(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x400943 <.text+0x6c3>
               	leaq	-0x18(%rbp), %rax
               	addq	$0x4, %rax
               	movzbq	(%rax), %rbx
               	xorq	$0x6f, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x28(%rbp)
               	jmp	0x400943 <.text+0x6c3>
               	movq	-0x28(%rbp), %rbx
               	movq	%rbx, -0x20(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x400988 <.text+0x708>
               	leaq	-0x18(%rbp), %rax
               	addq	$0x5, %rax
               	movzbq	(%rax), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x20(%rbp)
               	jmp	0x400988 <.text+0x708>
               	movq	-0x20(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x4009c0 <.text+0x740>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
