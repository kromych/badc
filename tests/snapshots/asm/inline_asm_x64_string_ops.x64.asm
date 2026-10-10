
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
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rax
               	movl	$0x4, %ecx
               	movq	%rax, %rdi
               	movl	$0xa5a5a5a5, %eax       # imm = 0xA5A5A5A5
               	rep		stosl	%eax, %es:(%rdi)
               	movl	-0x10(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	-0xc(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	-0x4(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movb	$0x61, -0x28(%rbp)
               	movb	$0x0, -0x20(%rbp)
               	movb	$0x62, -0x27(%rbp)
               	movb	$0x0, -0x1f(%rbp)
               	movb	$0x63, -0x26(%rbp)
               	movb	$0x0, -0x1e(%rbp)
               	movb	$0x64, -0x25(%rbp)
               	movb	$0x0, -0x1d(%rbp)
               	movb	$0x65, -0x24(%rbp)
               	movb	$0x0, -0x1c(%rbp)
               	movb	$0x66, -0x23(%rbp)
               	movb	$0x0, -0x1b(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	$0x6, %edx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	movq	%rdx, %rcx
               	rep		movsb	(%rsi), %es:(%rdi)
               	movsbq	-0x20(%rbp), %rax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movsbq	-0x1f(%rbp), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movsbq	-0x1e(%rbp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movsbq	-0x1d(%rbp), %rax
               	cmpl	$0x64, %eax
               	jne	<addr>
               	movsbq	-0x1c(%rbp), %rax
               	cmpl	$0x65, %eax
               	jne	<addr>
               	movsbq	-0x1b(%rbp), %rax
               	cmpl	$0x66, %eax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movl	$0x6, %ecx
               	movq	%rax, %rdi
               	movl	$0x64, %eax
               	repne		scasb	%es:(%rdi), %al
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	movw	$0x0, -0x18(%rbp)
               	movw	$0x1234, -0x16(%rbp)    # imm = 0x1234
               	movq	%rax, %rdi
               	movl	$0xbeef, %eax           # imm = 0xBEEF
               	stosw	%ax, %es:(%rdi)
               	movzwq	-0x18(%rbp), %rax
               	xorq	$0xbeef, %rax           # imm = 0xBEEF
               	testl	%eax, %eax
               	jne	<addr>
               	movzwq	-0x16(%rbp), %rax
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
