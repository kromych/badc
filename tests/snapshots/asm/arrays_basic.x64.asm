
arrays_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002ab <.text+0x8b>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	movl	%r8d, -0x10(%rbp)
               	jmp	0x400258 <.text+0x38>
               	movslq	-0x10(%rbp), %r8
               	cmpq	%r9, %r8
               	jge	0x40029e <.text+0x7e>
               	movslq	-0x8(%rbp), %r8
               	movslq	-0x10(%rbp), %rdi
               	movq	%rdi, %rsi
               	shlq	$0x2, %rsi
               	movq	%r11, %rdx
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rsi
               	movq	%r8, %rdx
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x8(%rbp)
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x10(%rbp)
               	jmp	0x400258 <.text+0x38>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x20(%rbp)
               	jmp	0x4002cb <.text+0xab>
               	movslq	-0x20(%rbp), %r11
               	cmpq	$0x5, %r11
               	jge	0x40031b <.text+0xfb>
               	leaq	-0x18(%rbp), %r11
               	movslq	-0x20(%rbp), %r9
               	movq	%r9, %r8
               	shlq	$0x2, %r8
               	movq	%r11, %rdi
               	addq	%r8, %rdi
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%rdi)
               	movslq	-0x20(%rbp), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x20(%rbp)
               	jmp	0x4002cb <.text+0xab>
               	leaq	-0x18(%rbp), %rbx
               	movl	$0x5, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0xf, %rax
               	je	0x40035a <.text+0x13a>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	je	0x400387 <.text+0x167>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movl	%r12d, -0x20(%rbp)
               	jmp	0x400393 <.text+0x173>
               	movslq	-0x20(%rbp), %r12
               	cmpq	$0x5, %r12
               	jge	0x4003e4 <.text+0x1c4>
               	leaq	0xfd25(%rip), %r12      # 0x4100d0
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %rbx
               	shlq	$0x2, %rbx
               	movq	%r12, %r11
               	addq	%rbx, %r11
               	movl	$0xa, %ebx
               	imulq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movl	%ebx, (%r11)
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0x1, %rbx
               	movslq	%ebx, %rbx
               	movl	%ebx, -0x20(%rbp)
               	jmp	0x400393 <.text+0x173>
               	leaq	0xfce5(%rip), %rbx      # 0x4100d0
               	movslq	(%rbx), %rax
               	movq	%rbx, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r12
               	movq	%rax, %r11
               	addq	%r12, %r11
               	movslq	%r11d, %r11
               	movq	%rbx, %r12
               	addq	$0x8, %r12
               	movslq	(%r12), %rax
               	movq	%r11, %r12
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	movq	%rbx, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %r11
               	movq	%r12, %rax
               	addq	%r11, %rax
               	movslq	%eax, %rax
               	movq	%rbx, %r11
               	addq	$0x10, %r11
               	movslq	(%r11), %rbx
               	movq	%rax, %r11
               	addq	%rbx, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x64, %r11
               	je	0x400472 <.text+0x252>
               	movl	$0x3, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	je	0x4004a0 <.text+0x280>
               	movl	$0x4, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	je	0x4004ce <.text+0x2ae>
               	movl	$0x5, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc13(%rip), %rbx      # 0x4100e8
               	xorq	%r11, %r11
               	movl	$0x68, %eax
               	movb	%al, (%rbx)
               	movq	%rbx, %r12
               	addq	$0x1, %r12
               	movl	$0x69, %eax
               	movb	%al, (%r12)
               	movq	%rbx, %rsi
               	addq	$0x2, %rsi
               	movb	%r11b, (%rsi)
               	movzbq	(%rbx), %rax
               	movq	%rax, %rbx
               	xorq	$0x68, %rbx
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	cmpq	$0x0, %rax
               	je	0x400540 <.text+0x320>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfba1(%rip), %rbx      # 0x4100e8
               	movq	%rbx, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rbx
               	movq	%rbx, %rax
               	xorq	$0x69, %rax
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rax, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400591 <.text+0x371>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb50(%rip), %rax      # 0x4100e8
               	movq	%rax, %rbx
               	addq	$0x2, %rbx
               	movzbq	(%rbx), %rax
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rax, %rbx
               	cmpq	$0x0, %rbx
               	je	0x4005d8 <.text+0x3b8>
               	movl	$0x8, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x20(%rbp)
               	jmp	0x4005e3 <.text+0x3c3>
               	movslq	-0x20(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	0x400652 <.text+0x432>
               	leaq	-0x40(%rbp), %rax
               	movslq	-0x20(%rbp), %rbx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%rax, %r11
               	addq	%rsi, %r11
               	movl	%ebx, (%r11)
               	leaq	-0x40(%rbp), %rsi
               	movslq	-0x20(%rbp), %r11
               	movq	%r11, %rbx
               	shlq	$0x3, %rbx
               	movq	%rsi, %rax
               	addq	%rbx, %rax
               	movq	%rax, %rbx
               	addq	$0x4, %rbx
               	movl	$0x64, %eax
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	movl	%eax, (%rbx)
               	movslq	-0x20(%rbp), %r11
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x20(%rbp)
               	jmp	0x4005e3 <.text+0x3c3>
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	0x400684 <.text+0x464>
               	movl	$0x9, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x1, %rax
               	je	0x4006bf <.text+0x49f>
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %r11
               	movq	%r11, %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %r11
               	cmpq	$0xc8, %r11
               	je	0x4006fb <.text+0x4db>
               	movl	$0xb, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400729 <.text+0x509>
               	movl	$0xc, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	movq	%rax, %r11
               	addq	$0x20, %r11
               	xorq	%rax, %rax
               	movl	%eax, (%r11)
               	movl	%eax, -0x20(%rbp)
               	jmp	0x400745 <.text+0x525>
               	movslq	-0x20(%rbp), %rax
               	cmpq	$0x8, %rax
               	jge	0x4007d7 <.text+0x5b7>
               	leaq	-0x68(%rbp), %rax
               	movslq	-0x20(%rbp), %rbx
               	movq	%rbx, %r11
               	shlq	$0x2, %r11
               	movq	%rax, %rsi
               	addq	%r11, %rsi
               	movq	%rbx, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, (%rsi)
               	leaq	-0x68(%rbp), %rbx
               	movq	%rbx, %r11
               	addq	$0x20, %r11
               	leaq	-0x68(%rbp), %rbx
               	movq	%rbx, %rsi
               	addq	$0x20, %rsi
               	movslq	(%rsi), %rbx
               	leaq	-0x68(%rbp), %rsi
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %r12
               	shlq	$0x2, %r12
               	movq	%rsi, %rax
               	addq	%r12, %rax
               	movslq	(%rax), %r12
               	movq	%rbx, %rax
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	movl	%eax, (%r11)
               	movslq	-0x20(%rbp), %r12
               	movq	%r12, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x20(%rbp)
               	jmp	0x400745 <.text+0x525>
               	leaq	-0x68(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x20, %r12
               	movslq	(%r12), %rax
               	cmpq	$0x24, %rax
               	je	0x400813 <.text+0x5f3>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movl	%r12d, -0x20(%rbp)
               	jmp	0x40081f <.text+0x5ff>
               	movslq	-0x20(%rbp), %r12
               	cmpq	$0x8, %r12
               	jge	0x400868 <.text+0x648>
               	leaq	-0x70(%rbp), %r12
               	movslq	-0x20(%rbp), %rax
               	movq	%r12, %r11
               	addq	%rax, %r11
               	movq	%rax, %r12
               	addq	$0x41, %r12
               	movslq	%r12d, %r12
               	movb	%r12b, (%r11)
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x20(%rbp)
               	jmp	0x40081f <.text+0x5ff>
               	leaq	-0x70(%rbp), %r12
               	movzbq	(%r12), %rax
               	movq	%rax, %r12
               	xorq	$0x41, %r12
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	cmpq	$0x0, %rax
               	je	0x4008ad <.text+0x68d>
               	movl	$0xe, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r12
               	movq	%r12, %rax
               	addq	$0x7, %rax
               	movzbq	(%rax), %r12
               	movq	%r12, %rax
               	xorq	$0x48, %rax
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rax, %r12
               	cmpq	$0x0, %r12
               	je	0x4008fd <.text+0x6dd>
               	movl	$0xf, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movslq	(%r12), %rax
               	movq	%r12, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rbx
               	movq	%rax, %r11
               	addq	%rbx, %r11
               	movslq	%r11d, %r11
               	movq	%r12, %rbx
               	addq	$0x8, %rbx
               	movslq	(%rbx), %r12
               	movq	%r11, %rbx
               	addq	%r12, %rbx
               	movslq	%ebx, %rbx
               	movslq	%ebx, %r12
               	cmpq	$0xc, %r12
               	je	0x400969 <.text+0x749>
               	movl	$0x10, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
