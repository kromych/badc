
inline_asm_x64_string_ops.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x18(%rbp)
               	movq	$0x4, -0x10(%rbp)
               	movq	-0x18(%rbp), %rdi
               	movq	-0x10(%rbp), %rcx
               	movl	$0xa5a5a5a5, %eax       # imm = 0xA5A5A5A5
               	rep		stosl	%eax, %es:(%rdi)
               	movq	%rdi, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	leaq	-0x40(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	(%rcx), %ecx
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	0x4(%rax), %ecx
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpl	%r11d, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpl	%r11d, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpl	%r11d, %eax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	leaq	(%rax), %rcx
               	movb	$0x61, (%rcx)
               	leaq	-0x28(%rbp), %rcx
               	leaq	(%rcx), %rsi
               	movb	$0x0, (%rsi)
               	movb	$0x62, 0x1(%rax)
               	movb	$0x0, 0x1(%rcx)
               	movb	$0x63, 0x2(%rax)
               	movb	$0x0, 0x2(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movb	$0x64, 0x3(%rax)
               	leaq	-0x28(%rbp), %rcx
               	movb	$0x0, 0x3(%rcx)
               	movb	$0x65, 0x4(%rax)
               	movb	$0x0, 0x4(%rcx)
               	movb	$0x66, 0x5(%rax)
               	movb	$0x0, 0x5(%rcx)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	$0x6, -0x8(%rbp)
               	movq	-0x18(%rbp), %rdi
               	movq	-0x10(%rbp), %rsi
               	movq	-0x8(%rbp), %rcx
               	rep		movsb	(%rsi), %es:(%rdi)
               	movq	%rdi, -0x18(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x61, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movsbq	0x1(%rax), %rcx
               	cmpl	$0x62, %ecx
               	jne	<addr>
               	movsbq	0x2(%rax), %rcx
               	cmpl	$0x63, %ecx
               	jne	<addr>
               	movsbq	0x3(%rax), %rcx
               	cmpl	$0x64, %ecx
               	jne	<addr>
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x65, %ecx
               	jne	<addr>
               	movsbq	0x5(%rax), %rax
               	cmpl	$0x66, %eax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	%rax, -0x18(%rbp)
               	movq	$0x6, -0x10(%rbp)
               	movq	-0x18(%rbp), %rdi
               	movq	-0x10(%rbp), %rcx
               	movl	$0x64, %eax
               	repne		scasb	%es:(%rdi), %al
               	movq	%rdi, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	movw	$0x0, (%rax)
               	movw	$0x1234, 0x2(%rax)      # imm = 0x1234
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdi
               	movl	$0xbeef, %eax           # imm = 0xBEEF
               	stosw	%ax, %es:(%rdi)
               	movq	%rdi, -0x18(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movzwq	(%rax), %rcx
               	xorq	$0xbeef, %rcx           # imm = 0xBEEF
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzwq	0x2(%rax), %rax
               	xorq	$0x1234, %rax           # imm = 0x1234
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	fninit
               	movl	$0x2a, %eax
               	leave
               	retq
