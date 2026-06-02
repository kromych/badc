
setjmp_longjmp_roundtrip.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %r11
               	movslq	%esi, %rbx
               	leaq	<rip>, %r8
               	movslq	(%r8), %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%r8)
               	cmpq	$0x0, %r11
               	jle	<addr>
               	subq	$0x1, %r11
               	movslq	%r11d, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %r11
               	movl	$0x1, %r9d
               	movl	%r9d, (%r11)
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %r9
               	xorq	%rax, %rax
               	movl	%eax, (%r9)
               	movl	$0x5, %edi
               	movl	$0x2a, %esi
               	callq	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x6, %rdi
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x2, %eax
               	movl	%eax, (%rdi)
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorq	%rsi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	movl	$0x15, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	xorq	%rax, %rax
               	movl	%eax, (%rdi)
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x1, %rdi
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x3, %eax
               	movl	%eax, (%rdi)
               	leaq	<rip>, %r9
               	xorq	%rax, %rax
               	movl	%eax, (%r9)
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x1, %eax
               	movl	%eax, (%rdi)
               	leaq	<rip>, %rdi
               	xorq	%rsi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	movl	$0x17, %eax
               	popq	%rbp
               	retq
               	movl	$0x16, %eax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x7, %rdi
               	je	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x7, %esi
               	movl	%esi, (%rdi)
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	movl	$0x1f, %eax
               	popq	%rbp
               	retq
               	movl	$0x20, %eax
               	popq	%rbp
               	retq
               	jmp	<addr>
