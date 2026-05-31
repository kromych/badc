
extern_decl_then_define.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %rax
               	retq
               	leaq	<rip>, %r11
               	leaq	<rip>, %r9
               	cmpq	%r9, %r11
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %r11
               	movl	(%r11), %eax
               	movl	$0xc1059ed8, %r11d      # imm = 0xC1059ED8
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %r11d
               	cmpq	$0x6a09e667, %r11       # imm = 0x6A09E667
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %r11
               	addq	$0x1c, %r11
               	movl	(%r11), %eax
               	movl	$0xbefa4fa4, %r11d      # imm = 0xBEFA4FA4
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x1c, %rax
               	movl	(%rax), %r11d
               	cmpq	$0x5be0cd19, %r11       # imm = 0x5BE0CD19
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %r11
               	leaq	<rip>, %rax
               	cmpq	%rax, %r11
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %r11
               	movl	(%r11), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r11
               	movl	$0xdeadbeef, %r10d      # imm = 0xDEADBEEF
               	cmpq	%r10, %r11
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
