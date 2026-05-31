
setjmp_longjmp_roundtrip.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400357 <.text+0xb7>
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
               	jle	0x40033a <.text+0x9a>
               	movq	%r11, %rsi
               	subq	$0x1, %rsi
               	movslq	%esi, %r12
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	0x4002b7 <.text+0x17>
               	jmp	0x40031a <.text+0x7a>
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd9f(%rip), %r14      # 0x4100e0
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	0x4007a7 <longjmp>
               	movzbq	%al, %rax
               	jmp	0x40031a <.text+0x7a>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xff74(%rip), %r11      # 0x4102f0
               	movl	$0x1, %r9d
               	movl	%r9d, (%r11)
               	leaq	0xfd54(%rip), %rbx      # 0x4100e0
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4007ad <setjmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	0x4003f0 <.text+0x150>
               	leaq	0xff33(%rip), %rax      # 0x4102e0
               	xorq	%rbx, %rbx
               	movl	%ebx, (%rax)
               	movl	$0x5, %r12d
               	movl	$0x2a, %r14d
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	0x4002b7 <.text+0x17>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfee9(%rip), %r14      # 0x4102e0
               	movslq	(%r14), %rax
               	cmpq	$0x6, %rax
               	je	0x40042e <.text+0x18e>
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfebb(%rip), %r14      # 0x4102f0
               	movl	$0x2, %eax
               	movl	%eax, (%r14)
               	leaq	0xfc9c(%rip), %rbx      # 0x4100e0
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4007ad <setjmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	0x4004a0 <.text+0x200>
               	leaq	0xfc7b(%rip), %r12      # 0x4100e0
               	xorq	%r15, %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x4007a7 <longjmp>
               	movzbq	%al, %rax
               	movl	$0x15, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfe41(%rip), %r15      # 0x4102e8
               	xorq	%rax, %rax
               	movl	%eax, (%r15)
               	leaq	0xfc2c(%rip), %r14      # 0x4100e0
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x4007ad <setjmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x40052d <.text+0x28d>
               	leaq	0xfe13(%rip), %rax      # 0x4102e8
               	movslq	(%rax), %r14
               	cmpq	$0x1, %r14
               	je	0x4005a7 <.text+0x307>
               	jmp	0x40057f <.text+0x2df>
               	leaq	0xfdff(%rip), %r15      # 0x4102f0
               	movl	$0x3, %eax
               	movl	%eax, (%r15)
               	leaq	0xfde8(%rip), %r12      # 0x4102e8
               	xorq	%rax, %rax
               	movl	%eax, (%r12)
               	leaq	0xfbd2(%rip), %r14      # 0x4100e0
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x4007ad <setjmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x4005ed <.text+0x34d>
               	jmp	0x4005ac <.text+0x30c>
               	leaq	0xfdb4(%rip), %rax      # 0x4102e8
               	movl	$0x1, %r14d
               	movl	%r14d, (%rax)
               	leaq	0xfb9c(%rip), %r12      # 0x4100e0
               	xorq	%r15, %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x4007a7 <longjmp>
               	movzbq	%al, %rax
               	movl	$0x17, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x16, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	0x4004ea <.text+0x24a>
               	leaq	0xfd35(%rip), %rax      # 0x4102e8
               	movslq	(%rax), %r14
               	cmpq	$0x7, %r14
               	je	0x400664 <.text+0x3c4>
               	jmp	0x40063c <.text+0x39c>
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfcf4(%rip), %rax      # 0x4102e8
               	movl	$0x7, %r15d
               	movl	%r15d, (%rax)
               	leaq	0xfadc(%rip), %r14      # 0x4100e0
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x4007a7 <longjmp>
               	movzbq	%al, %rax
               	movl	$0x1f, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x20, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	0x4005c8 <.text+0x328>
               	addb	%al, (%rax)
