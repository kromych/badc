
c99_qualifiers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	movq	%rsi, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	addq	%r9, %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	movq	%r8, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %r8
               	cmpq	%r9, %r8
               	jae	<addr>
               	movslq	-0x8(%rbp), %rdi
               	movslq	(%r11), %r8
               	addq	%r8, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x8(%rbp)
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
               	subq	$0x60, %rsp
               	movl	$0x7, %r11d
               	movl	%r11d, -0x28(%rbp)
               	leaq	-0x28(%rbp), %r9
               	movl	$0x1, %r11d
               	movl	$0x2, %r8d
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	addq	%r8, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x3, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %r11d
               	jmp	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movzbq	(%rdi), %rax
               	xorq	$0x62, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, %edi
               	movl	%edi, (%rax)
               	movl	(%rax), %esi
               	xorq	$0x1, %rsi
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	jmp	<addr>
               	movq	-0x50(%rbp), %rsi
               	cmpq	%r11, %rsi
               	jae	<addr>
               	movslq	-0x58(%rbp), %rax
               	movslq	(%r9), %rsi
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x58(%rbp)
               	movq	-0x50(%rbp), %rsi
               	addq	$0x1, %rsi
               	movq	%rsi, -0x50(%rbp)
               	jmp	<addr>
               	movslq	-0x58(%rbp), %rax
               	jmp	<addr>
