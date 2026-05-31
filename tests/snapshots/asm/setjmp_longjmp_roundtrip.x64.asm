
setjmp_longjmp_roundtrip.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40035d <.text+0xbd>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100d0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %r11
               	movslq	%esi, %rbx
               	leaq	0x10003(%rip), %r8      # 0x4102e0
               	movslq	(%r8), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, (%r8)
               	cmpq	$0x0, %r11
               	jle	0x40033d <.text+0x9d>
               	movq	%r11, %rsi
               	subq	$0x1, %rsi
               	movslq	%esi, %r12
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	0x4002b7 <.text+0x17>
               	movq	%rax, %r11
               	jmp	0x40031d <.text+0x7d>
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd9c(%rip), %r14      # 0x4100e0
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	0x4007d7 <longjmp>
               	movzbq	%al, %rax
               	movq	%rax, %r11
               	jmp	0x40031d <.text+0x7d>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xff6e(%rip), %r11      # 0x4102f0
               	movl	$0x1, %r9d
               	movl	%r9d, (%r11)
               	leaq	0xfd4e(%rip), %rbx      # 0x4100e0
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4007dd <setjmp>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	cmpq	$0x0, %r9
               	jne	0x4003fe <.text+0x15e>
               	leaq	0xff2a(%rip), %r9       # 0x4102e0
               	xorq	%rbx, %rbx
               	movl	%ebx, (%r9)
               	movl	$0x5, %r12d
               	movl	$0x2a, %r14d
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	0x4002b7 <.text+0x17>
               	movq	%rax, %r9
               	movl	$0xb, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfedb(%rip), %r14      # 0x4102e0
               	movslq	(%r14), %r9
               	cmpq	$0x6, %r9
               	je	0x40043d <.text+0x19d>
               	movl	$0xc, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfeac(%rip), %r14      # 0x4102f0
               	movl	$0x2, %r9d
               	movl	%r9d, (%r14)
               	leaq	0xfc8c(%rip), %rbx      # 0x4100e0
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4007dd <setjmp>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	cmpq	$0x0, %r9
               	jne	0x4004b7 <.text+0x217>
               	leaq	0xfc68(%rip), %r12      # 0x4100e0
               	xorq	%r15, %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x4007d7 <longjmp>
               	movzbq	%al, %rax
               	movq	%rax, %r14
               	movl	$0x15, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfe2a(%rip), %r15      # 0x4102e8
               	xorq	%r14, %r14
               	movl	%r14d, (%r15)
               	leaq	0xfc15(%rip), %rbx      # 0x4100e0
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4007dd <setjmp>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	cmpq	$0x0, %r14
               	je	0x40054b <.text+0x2ab>
               	leaq	0xfdf9(%rip), %r14      # 0x4102e8
               	movslq	(%r14), %rbx
               	cmpq	$0x1, %rbx
               	je	0x4005c7 <.text+0x327>
               	jmp	0x4005a0 <.text+0x300>
               	leaq	0xfde5(%rip), %r15      # 0x4102f0
               	movl	$0x3, %r14d
               	movl	%r14d, (%r15)
               	leaq	0xfdcd(%rip), %r12      # 0x4102e8
               	xorq	%r14, %r14
               	movl	%r14d, (%r12)
               	leaq	0xfbb7(%rip), %rbx      # 0x4100e0
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4007dd <setjmp>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	cmpq	$0x0, %r14
               	je	0x40060d <.text+0x36d>
               	jmp	0x4005cc <.text+0x32c>
               	leaq	0xfd96(%rip), %r14      # 0x4102e8
               	movl	$0x1, %ebx
               	movl	%ebx, (%r14)
               	leaq	0xfb7f(%rip), %r12      # 0x4100e0
               	xorq	%r15, %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x4007d7 <longjmp>
               	movzbq	%al, %rax
               	movq	%rax, %r14
               	movl	$0x17, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x16, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	0x400504 <.text+0x264>
               	leaq	0xfd15(%rip), %r14      # 0x4102e8
               	movslq	(%r14), %rbx
               	cmpq	$0x7, %rbx
               	je	0x400687 <.text+0x3e7>
               	jmp	0x400660 <.text+0x3c0>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfcd4(%rip), %r14      # 0x4102e8
               	movl	$0x7, %r15d
               	movl	%r15d, (%r14)
               	leaq	0xfabc(%rip), %rbx      # 0x4100e0
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x4007d7 <longjmp>
               	movzbq	%al, %rax
               	movq	%rax, %r14
               	movl	$0x1f, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x20, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	0x4005e8 <.text+0x348>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
