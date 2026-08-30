
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
               	subq	$0x80, %rsp
               	leaq	-0x40(%rbp), %rax
               	movl	$0x4, %ecx
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	$0xa5a5a5a5, %edx       # imm = 0xA5A5A5A5
               	movq	%rax, -0x80(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movq	%rdi, -0x70(%rbp)
               	movq	%rax, -0x68(%rbp)
               	movq	%rcx, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	movq	-0x68(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x60(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x58(%rbp), %rax
               	rep		stosl	%eax, %es:(%rdi)
               	movq	-0x68(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x60(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rcx
               	movq	-0x70(%rbp), %rdi
               	leaq	-0x40(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	(%rcx), %ecx
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
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
               	movl	$0x61, %edx
               	movb	%dl, (%rcx)
               	leaq	-0x28(%rbp), %rcx
               	leaq	(%rcx), %rsi
               	xorq	%rdx, %rdx
               	movb	%dl, (%rsi)
               	movl	$0x62, %esi
               	movb	%sil, 0x1(%rax)
               	movb	%dl, 0x1(%rcx)
               	movl	$0x63, %esi
               	movb	%sil, 0x2(%rax)
               	movb	%dl, 0x2(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x64, %ecx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x28(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movb	%dl, 0x3(%rcx)
               	movl	$0x65, %esi
               	movb	%sil, 0x4(%rax)
               	movb	%dl, 0x4(%rcx)
               	movl	$0x66, %esi
               	movb	%sil, 0x5(%rax)
               	movb	%dl, 0x5(%rcx)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movl	$0x6, %edx
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	movq	%rcx, -0x80(%rbp)
               	movq	%rsi, -0x78(%rbp)
               	movq	%rdi, -0x70(%rbp)
               	movq	%rax, -0x68(%rbp)
               	movq	%rcx, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	movq	-0x68(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x60(%rbp), %r10
               	movq	(%r10), %rsi
               	movq	-0x58(%rbp), %r10
               	movq	(%r10), %rcx
               	rep		movsb	(%rsi), %es:(%rdi)
               	movq	-0x68(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x60(%rbp), %r10
               	movq	%rsi, (%r10)
               	movq	-0x58(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	movq	-0x70(%rbp), %rdi
               	leaq	-0x28(%rbp), %rax
               	leaq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x61, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
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
               	movl	$0x6, %ecx
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movl	$0x64, %eax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, -0x80(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movq	%rdi, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	-0x68(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x60(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x58(%rbp), %rax
               	repne		scasb	%es:(%rdi), %al
               	movq	-0x68(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x60(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rcx
               	movq	-0x70(%rbp), %rdi
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movw	%cx, (%rax)
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, 0x2(%rax)
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xbeef, %ecx           # imm = 0xBEEF
               	movq	%rax, -0x80(%rbp)
               	movq	%rdi, -0x78(%rbp)
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x68(%rbp), %rax
               	stosw	%ax, %es:(%rdi)
               	movq	-0x70(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rdi
               	leaq	-0x20(%rbp), %rax
               	movzwq	(%rax), %rcx
               	xorq	$0xbeef, %rcx           # imm = 0xBEEF
               	movl	%ecx, %edx
               	testl	%edx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzwq	0x2(%rax), %rax
               	xorq	$0x1234, %rax           # imm = 0x1234
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	fninit
               	movl	$0x2a, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
