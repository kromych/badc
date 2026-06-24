
extern_decl_then_define.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<peek_via_extern>:
               	leaq	<rip>, %rax
               	retq

<main>:
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	(%rax), %edx
               	movl	$0xc1059ed8, %r11d      # imm = 0xC1059ED8
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	(%rcx), %edx
               	cmpq	$0x6a09e667, %rdx       # imm = 0x6A09E667
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	0x1c(%rax), %eax
               	movl	$0xbefa4fa4, %r11d      # imm = 0xBEFA4FA4
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	0x1c(%rcx), %eax
               	cmpq	$0x5be0cd19, %rax       # imm = 0x5BE0CD19
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movl	$0xdeadbeef, %r11d      # imm = 0xDEADBEEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
