
static_inline_function.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002df <.text+0xbf>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movl	$0x3, %r9d
               	imulq	%r11, %r9
               	movslq	%r9d, %r9
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %rax
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movq	%r11, 0x10(%rbp)
               	xorq	%r9, %r9
               	movq	%r9, -0x8(%rbp)
               	jmp	0x400282 <.text+0x62>
               	movq	0x10(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x4002c7 <.text+0xa7>
               	leaq	-0x8(%rbp), %r11
               	movq	(%r11), %r9
               	movq	0x10(%rbp), %r8
               	movq	%r8, %rdi
               	andq	$0x1, %rdi
               	movq	%r9, %r8
               	addq	%rdi, %r8
               	movq	%r8, (%r11)
               	leaq	0x10(%rbp), %rdi
               	movq	(%rdi), %r8
               	movq	%r8, %r11
               	shrq	$0x1, %r11
               	movq	%r11, (%rdi)
               	jmp	0x400282 <.text+0x62>
               	movq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r9
               	cmpq	$0x7, %r9
               	je	0x40032e <.text+0x10e>
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r9
               	cmpq	$-0x2, %r9
               	je	0x40036e <.text+0x14e>
               	movl	$0x2, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xdeadbeef, %ebx       # imm = 0xDEADBEEF
               	movq	%rbx, %rdi
               	callq	0x400255 <.text+0x35>
               	movq	%rax, %r9
               	cmpq	$0x18, %r9
               	je	0x4003a9 <.text+0x189>
               	movl	$0x3, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rdi
               	callq	0x400255 <.text+0x35>
               	movq	%rax, %r9
               	cmpq	$0x0, %r9
               	je	0x4003e2 <.text+0x1c2>
               	movl	$0x4, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
