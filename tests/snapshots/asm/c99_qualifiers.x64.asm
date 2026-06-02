
c99_qualifiers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	addq	%rsi, %rdi
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rdi, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	movq	%r8, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %r8
               	cmpq	%rsi, %r8
               	jae	<addr>
               	movslq	-0x8(%rbp), %r11
               	movslq	(%rdi), %r8
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x8(%rbp)
               	movq	-0x10(%rbp), %r8
               	addq	$0x1, %r8
               	movq	%r8, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0x7, %r11d
               	movl	%r11d, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x1, %r11d
               	movl	$0x2, %r8d
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	addq	%r8, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x3, %r11
               	je	<addr>
               	movl	$0x1, %r8d
               	movq	%r8, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %esi
               	movq	%rsi, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x62, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %esi
               	movq	%rsi, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %esi
               	movq	%rsi, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %esi
               	movq	%rsi, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, %esi
               	movl	%esi, (%rax)
               	movl	(%rax), %eax
               	xorq	$0x1, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %edi
               	movq	%rdi, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
