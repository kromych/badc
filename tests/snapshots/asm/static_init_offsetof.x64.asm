
static_init_offsetof.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%rax, %rcx
               	addq	$0x1, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x4, %rcx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rax, %rcx
               	addq	$0x2, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x8, %rcx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%rax, %rcx
               	addq	$0x3, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x10, %rcx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	addq	$0x4, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x12, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, 0x41(%rdx)
