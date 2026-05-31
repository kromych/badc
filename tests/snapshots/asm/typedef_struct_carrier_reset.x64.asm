
typedef_struct_carrier_reset.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40032d <.text+0x10d>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	movl	%r9d, -0x8(%rbp)
               	jmp	0x400255 <.text+0x35>
               	movslq	-0x8(%rbp), %r9
               	cmpq	$0xa, %r9
               	jge	0x400307 <.text+0xe7>
               	jmp	0x400284 <.text+0x64>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r9)
               	jmp	0x400255 <.text+0x35>
               	movslq	-0x8(%rbp), %rdi
               	movq	%rdi, %r8
               	shlq	$0x2, %r8
               	movq	%r11, %r9
               	addq	%r8, %r9
               	movl	%edi, (%r9)
               	movq	%r11, %r8
               	addq	$0x28, %r8
               	movslq	-0x8(%rbp), %r9
               	movq	%r9, %rdi
               	shlq	$0x2, %rdi
               	movq	%r8, %rsi
               	addq	%rdi, %rsi
               	movq	%r9, %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%rsi)
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %rdi
               	movslq	-0x8(%rbp), %rsi
               	movq	%rsi, %r8
               	shlq	$0x2, %r8
               	movq	%r11, %rsi
               	addq	%r8, %rsi
               	movslq	(%rsi), %rdx
               	movq	%r11, %rsi
               	addq	$0x28, %rsi
               	movq	%rsi, %rcx
               	addq	%r8, %rcx
               	movslq	(%rcx), %rsi
               	movq	%rdx, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movq	%rdi, %rsi
               	addq	%rcx, %rsi
               	movl	%esi, (%r9)
               	jmp	0x40026b <.text+0x4b>
               	movq	%r11, %rsi
               	addq	$0xa0, %rsi
               	movslq	-0x10(%rbp), %rcx
               	movl	%ecx, (%rsi)
               	movq	%r11, %r9
               	addq	$0xa0, %r9
               	movslq	(%r9), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0xa8(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	movslq	%eax, %rbx
               	cmpq	$0x64, %rbx
               	je	0x400373 <.text+0x153>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0x14, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x5, %rax
               	je	0x4003ac <.text+0x18c>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rbx
               	movq	%rbx, %rax
               	addq	$0x3c, %rax
               	movslq	(%rax), %rbx
               	cmpq	$0x6, %rbx
               	je	0x4003e5 <.text+0x1c5>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0xa0, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x64, %rax
               	je	0x40041e <.text+0x1fe>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
