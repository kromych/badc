
static_init_paren_cast_string.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x5, %rcx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	(%rax), %rcx
               	addq	$0x5, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x1a, %rcx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rax, %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x9, %rcx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%rax, %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x9, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x4, %rcx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	addq	$0x10, %rax
               	movq	(%rax), %rax
               	addq	$0x9, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x1, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
