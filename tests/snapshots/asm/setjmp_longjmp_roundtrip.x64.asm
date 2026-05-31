
setjmp_longjmp_roundtrip.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400351 <.text+0xb1>
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
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%r8)
               	cmpq	$0x0, %r11
               	jle	0x400334 <.text+0x94>
               	subq	$0x1, %r11
               	movslq	%r11d, %r12
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	0x4002b7 <.text+0x17>
               	jmp	0x400314 <.text+0x74>
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfda5(%rip), %r14      # 0x4100e0
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	0x400777 <longjmp>
               	movzbq	%al, %rax
               	jmp	0x400314 <.text+0x74>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	0xff7f(%rip), %r11      # 0x4102f0
               	movl	$0x1, %r9d
               	movl	%r9d, (%r11)
               	leaq	0xfd5f(%rip), %rbx      # 0x4100e0
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x40077d <setjmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	0x4003e0 <.text+0x140>
               	leaq	0xff3e(%rip), %rbx      # 0x4102e0
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
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
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfef9(%rip), %r14      # 0x4102e0
               	movslq	(%r14), %rax
               	cmpq	$0x6, %rax
               	je	0x40041a <.text+0x17a>
               	movl	$0xc, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfecf(%rip), %rax      # 0x4102f0
               	movl	$0x2, %r14d
               	movl	%r14d, (%rax)
               	leaq	0xfcaf(%rip), %rbx      # 0x4100e0
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x40077d <setjmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	0x400488 <.text+0x1e8>
               	leaq	0xfc8e(%rip), %r12      # 0x4100e0
               	xorq	%rbx, %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	0x400777 <longjmp>
               	movzbq	%al, %rax
               	movl	$0x15, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfe59(%rip), %rbx      # 0x4102e8
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	leaq	0xfc45(%rip), %r14      # 0x4100e0
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x40077d <setjmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400513 <.text+0x273>
               	leaq	0xfe2c(%rip), %r14      # 0x4102e8
               	movslq	(%r14), %rax
               	cmpq	$0x1, %rax
               	je	0x400583 <.text+0x2e3>
               	jmp	0x400560 <.text+0x2c0>
               	leaq	0xfe18(%rip), %rbx      # 0x4102f0
               	movl	$0x3, %eax
               	movl	%eax, (%rbx)
               	leaq	0xfe02(%rip), %r12      # 0x4102e8
               	xorq	%rax, %rax
               	movl	%eax, (%r12)
               	leaq	0xfbec(%rip), %r14      # 0x4100e0
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x40077d <setjmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x4005c4 <.text+0x324>
               	jmp	0x400588 <.text+0x2e8>
               	leaq	0xfdce(%rip), %rax      # 0x4102e8
               	movl	$0x1, %r14d
               	movl	%r14d, (%rax)
               	leaq	0xfbb6(%rip), %r12      # 0x4100e0
               	xorq	%rbx, %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	0x400777 <longjmp>
               	movzbq	%al, %rax
               	movl	$0x17, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x16, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	0x4004d1 <.text+0x231>
               	leaq	0xfd59(%rip), %r14      # 0x4102e8
               	movslq	(%r14), %rax
               	cmpq	$0x7, %rax
               	je	0x40062f <.text+0x38f>
               	jmp	0x40060c <.text+0x36c>
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd1d(%rip), %rax      # 0x4102e8
               	movl	$0x7, %ebx
               	movl	%ebx, (%rax)
               	leaq	0xfb07(%rip), %r14      # 0x4100e0
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	0x400777 <longjmp>
               	movzbq	%al, %rax
               	movl	$0x1f, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x20, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	0x4005a4 <.text+0x304>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
