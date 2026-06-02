
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
               	movl	(%r11), %r8d
               	movl	$0xc1059ed8, %r10d      # imm = 0xC1059ED8
               	cmpq	%r10, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	(%r9), %r8d
               	cmpq	$0x6a09e667, %r8        # imm = 0x6A09E667
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	addq	$0x1c, %r11
               	movl	(%r11), %r11d
               	movl	$0xbefa4fa4, %r10d      # imm = 0xBEFA4FA4
               	cmpq	%r10, %r11
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	addq	$0x1c, %r9
               	movl	(%r9), %r9d
               	cmpq	$0x5be0cd19, %r9        # imm = 0x5BE0CD19
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %r9
               	leaq	<rip>, %rax
               	cmpq	%rax, %r9
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %r9
               	movl	(%r9), %r9d
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %r9
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r9
               	movl	$0xdeadbeef, %r11d      # imm = 0xDEADBEEF
               	cmpq	%r11, %r9
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	retq
