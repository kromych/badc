
archive_format_constants.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x200, %rsp            # imm = 0x200
               	leaq	-0x200(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	movups	%xmm14, 0x80(%rax)
               	movups	%xmm14, 0x90(%rax)
               	movups	%xmm14, 0xa0(%rax)
               	movups	%xmm14, 0xb0(%rax)
               	movups	%xmm14, 0xc0(%rax)
               	movups	%xmm14, 0xd0(%rax)
               	movups	%xmm14, 0xe0(%rax)
               	movups	%xmm14, 0xf0(%rax)
               	movups	%xmm14, 0x100(%rax)
               	movups	%xmm14, 0x110(%rax)
               	movups	%xmm14, 0x120(%rax)
               	movups	%xmm14, 0x130(%rax)
               	movups	%xmm14, 0x140(%rax)
               	movups	%xmm14, 0x150(%rax)
               	movups	%xmm14, 0x160(%rax)
               	movups	%xmm14, 0x170(%rax)
               	movups	%xmm14, 0x180(%rax)
               	movups	%xmm14, 0x190(%rax)
               	movups	%xmm14, 0x1a0(%rax)
               	movups	%xmm14, 0x1b0(%rax)
               	movups	%xmm14, 0x1c0(%rax)
               	movups	%xmm14, 0x1d0(%rax)
               	movups	%xmm14, 0x1e0(%rax)
               	movups	%xmm14, 0x1f0(%rax)
               	leaq	0x101(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x6, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x200(%rbp), %rax
               	leaq	0x107(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x200(%rbp), %rax
               	movb	$0x35, -0x164(%rbp)
               	leaq	0x101(%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	-0xf9(%rbp), %rax
               	cmpl	$0x30, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movsbq	-0x164(%rbp), %rax
               	cmpl	$0x35, %eax
               	setne	%al
               	movzbq	%al, %rax
               	leave
               	retq
