
deferred_outer_2d_array_stride.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003b6 <.text+0x136>
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
               	callq	0x400847 <dlsym>
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
               	subq	$0x20, %rsp
               	movl	$0x30, %r11d
               	cmpq	$0x30, %r11
               	je	0x4003e2 <.text+0x162>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x10, %r11d
               	cmpq	$0x10, %r11
               	je	0x400403 <.text+0x183>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x10, %r11d
               	cmpq	$0x10, %r11
               	je	0x400424 <.text+0x1a4>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd2d(%rip), %r11      # 0x410158
               	movq	%r11, %rax
               	addq	$0x10, %rax
               	subq	%r11, %rax
               	cmpq	$0x10, %rax
               	je	0x400457 <.text+0x1d7>
               	movl	$0x4, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfcfa(%rip), %rax      # 0x410158
               	movq	%rax, %r11
               	addq	$0x20, %r11
               	addq	$0x10, %rax
               	subq	%rax, %r11
               	cmpq	$0x10, %r11
               	je	0x40048d <.text+0x20d>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfcc4(%rip), %r11      # 0x410158
               	movq	(%r11), %rax
               	movzbq	(%rax), %r11
               	xorq	$0x41, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x8(%rbp)
               	cmpq	$0x0, %r11
               	jne	0x400508 <.text+0x288>
               	leaq	0xfc86(%rip), %rax      # 0x410158
               	addq	$0x8, %rax
               	movq	(%rax), %r11
               	movzbq	(%r11), %rax
               	xorq	$0x42, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	0x400508 <.text+0x288>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x40052b <.text+0x2ab>
               	movl	$0x6, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc26(%rip), %rax      # 0x410158
               	addq	$0x10, %rax
               	movq	(%rax), %r11
               	movzbq	(%r11), %rax
               	xorq	$0x43, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x10(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400599 <.text+0x319>
               	leaq	0xfbe1(%rip), %r11      # 0x410158
               	addq	$0x18, %r11
               	movq	(%r11), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x10(%rbp)
               	jmp	0x400599 <.text+0x319>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x4005bc <.text+0x33c>
               	movl	$0x7, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb95(%rip), %rax      # 0x410158
               	addq	$0x20, %rax
               	movq	(%rax), %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x18(%rbp)
               	cmpq	$0x0, %r11
               	jne	0x40062a <.text+0x3aa>
               	leaq	0xfb64(%rip), %rax      # 0x410158
               	addq	$0x28, %rax
               	movq	(%rax), %r11
               	movzbq	(%r11), %rax
               	xorq	$0x44, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	0x40062a <.text+0x3aa>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x40064d <.text+0x3cd>
               	movl	$0x8, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x30, %eax
               	cmpq	$0x30, %rax
               	je	0x400671 <.text+0x3f1>
               	movl	$0x9, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xc, %eax
               	cmpq	$0xc, %rax
               	je	0x400695 <.text+0x415>
               	movl	$0xa, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfaec(%rip), %rax      # 0x410188
               	addq	$0x2c, %rax
               	movslq	(%rax), %r11
               	cmpq	$0xc, %r11
               	je	0x4006c1 <.text+0x441>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfac0(%rip), %r11      # 0x410188
               	addq	$0x10, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x5, %rax
               	je	0x4006f1 <.text+0x471>
               	movl	$0xc, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
