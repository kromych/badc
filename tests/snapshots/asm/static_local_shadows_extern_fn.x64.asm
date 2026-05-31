
static_local_shadows_extern_fn.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002cd <.text+0xad>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movq	%rdi, %r11
               	movzbq	(%r11), %r9
               	addq	$0x1, %r11
               	movzbq	(%r11), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %r11
               	xorq	%r9, %r9
               	movl	%r9d, -0x8(%rbp)
               	jmp	0x4002ae <.text+0x8e>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfe44(%rip), %rbx      # 0x4100d0
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	movl	%eax, -0x8(%rbp)
               	jmp	0x40026e <.text+0x4e>
               	movabsq	$-0x1, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x40026e <.text+0x4e>
               	cmpq	$0x1, %r11
               	je	0x400285 <.text+0x65>
               	cmpq	$0x2, %r11
               	je	0x40029c <.text+0x7c>
               	jmp	0x40026e <.text+0x4e>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x1, %ebx
               	movq	%rbx, %rdi
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	jmp	0x400250 <.text+0x30>
               	addb	%al, (%rax)
