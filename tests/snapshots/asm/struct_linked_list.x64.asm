
struct_linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100d8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%r11, %r11
               	movq	%r11, -0x8(%rbp)
               	movl	%r11d, -0x20(%rbp)
               	jmp	0x4002a6 <.text+0x36>
               	movslq	-0x20(%rbp), %r11
               	cmpq	$0x5, %r11
               	jge	0x400318 <.text+0xa8>
               	jmp	0x4002d5 <.text+0x65>
               	leaq	-0x20(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x4002a6 <.text+0x36>
               	movl	$0x10, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4004c7 <malloc>
               	movq	%rax, %r9
               	movq	%r9, -0x10(%rbp)
               	movq	-0x10(%rbp), %rbx
               	movslq	-0x20(%rbp), %r9
               	movl	%r9d, (%rbx)
               	movq	-0x10(%rbp), %r11
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movq	-0x8(%rbp), %r11
               	movq	%r11, (%r9)
               	movq	-0x10(%rbp), %rbx
               	movq	%rbx, -0x8(%rbp)
               	jmp	0x4002bc <.text+0x4c>
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x18(%rbp)
               	movq	-0x8(%rbp), %r11
               	movq	%r11, -0x10(%rbp)
               	jmp	0x40032b <.text+0xbb>
               	movq	-0x10(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400369 <.text+0xf9>
               	movslq	-0x18(%rbp), %r11
               	movq	-0x10(%rbp), %rbx
               	movslq	(%rbx), %r9
               	movq	%r11, %rdi
               	addq	%r9, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x18(%rbp)
               	movq	%rbx, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %rbx
               	movq	%rbx, -0x10(%rbp)
               	jmp	0x40032b <.text+0xbb>
               	movslq	-0x18(%rbp), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
